package main

import (
	"context"
	"crypto/sha1"
	"encoding/hex"
	"encoding/xml"
	"flag"
	"fmt"
	"io"
	"log"
	"net/http"
	"net/url"
	"os"
	"path/filepath"
	"strings"
	"time"
)

const (
	rssURL    = "https://www.sec.gov/cgi-bin/browse-edgar?action=getcompany&CIK=0001067983&output=atom"
	userAgent = "Aktagon Ltd. (https://aktagon.com; support@aktagon.com)"
)

type Feed struct {
	Entries []Entry `xml:"entry"`
}

type Entry struct {
	Link Link `xml:"link"`
}

type Link struct {
	Href string `xml:"href,attr"`
}

func main() {
	dir, max := parseFlags()
	if err := run(dir, max); err != nil {
		log.Fatalf("error: %v", err)
	}
}

func parseFlags() (string, int) {
	dir := flag.String("dir", "downloads", "destination directory")
	max := flag.Int("n", 5, "number of filings to fetch (0 = all)")
	flag.Parse()
	return *dir, *max
}

func run(dir string, max int) error {
	if err := os.MkdirAll(dir, 0o755); err != nil {
		return fmt.Errorf("creating directory %s: %w", dir, err)
	}

	client := &http.Client{Timeout: 30 * time.Second}
	ctx := context.Background()

	body, err := fetch(ctx, client, rssURL)
	if err != nil {
		return err
	}

	feed, err := parseFeed(body)
	if err != nil {
		return fmt.Errorf("parsing feed: %w", err)
	}

	count := 0
	for _, entry := range feed.Entries {
		if max > 0 && count >= max {
			break
		}
		link := entry.Link.Href
		if err := download(ctx, client, link, dir); err != nil {
			fmt.Fprintf(os.Stderr, "skip %s: %v\n", link, err)
			continue
		}
		count++
	}

	return nil
}

func fetch(ctx context.Context, client *http.Client, urlStr string) ([]byte, error) {
	req, err := http.NewRequestWithContext(ctx, http.MethodGet, urlStr, nil)
	if err != nil {
		return nil, fmt.Errorf("creating request: %w", err)
	}
	req.Header.Set("User-Agent", userAgent)

	resp, err := client.Do(req)
	if err != nil {
		return nil, fmt.Errorf("fetching %s: %w", urlStr, err)
	}
	defer resp.Body.Close()

	if resp.StatusCode < 200 || resp.StatusCode >= 300 {
		return nil, fmt.Errorf("unexpected status code %d", resp.StatusCode)
	}

	data, err := io.ReadAll(resp.Body)
	if err != nil {
		return nil, fmt.Errorf("reading response body: %w", err)
	}
	return data, nil
}

func parseFeed(data []byte) (*Feed, error) {
	// Remove XML declaration to avoid unsupported charset errors
	s := string(data)
	if strings.HasPrefix(s, "<?xml") {
		if idx := strings.Index(s, "?>"); idx != -1 {
			s = s[idx+2:]
		}
	}

	var feed Feed
	if err := xml.Unmarshal([]byte(s), &feed); err != nil {
		return nil, err
	}
	return &feed, nil
}

func download(ctx context.Context, c *http.Client, link, dir string) error {
	req, err := http.NewRequestWithContext(ctx, http.MethodGet, link, nil)
	if err != nil {
		return fmt.Errorf("creating request for %s: %w", link, err)
	}
	req.Header.Set("User-Agent", userAgent)

	resp, err := c.Do(req)
	if err != nil {
		return fmt.Errorf("downloading %s: %w", link, err)
	}
	defer resp.Body.Close()

	if resp.StatusCode < 200 || resp.StatusCode >= 300 {
		return fmt.Errorf("unexpected status code %d for %s", resp.StatusCode, link)
	}

	name := fileName(link)
	path := filepath.Join(dir, name)
	f, err := os.Create(path)
	if err != nil {
		return fmt.Errorf("creating file %s: %w", path, err)
	}
	defer f.Close()

	if _, err := io.Copy(f, resp.Body); err != nil {
		return fmt.Errorf("writing to %s: %w", path, err)
	}

	return nil
}

func fileName(link string) string {
	u, err := url.Parse(link)
	if err != nil {
		sum := sha1.Sum([]byte(link))
		return hex.EncodeToString(sum[:]) + ".html"
	}
	return filepath.Base(u.Path)
}
