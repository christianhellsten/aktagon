.PHONY: dev build new-post clean

dev:
	hugo server -D --bind 0.0.0.0 --disableFastRender

build: clean
	hugo --minify

new-post:
	@read -p "Enter post slug: " slug; \
	hugo new posts/$(shell date +%Y)/$$slug.md

deploy: build
	wrangler pages deploy public/

clean:
	rm -rf public/

install:
	@echo "Ensure Hugo is installed: https://gohugo.io/installation/"
	@echo "Ensure postcss tools are installed: https://gohugo.io/functions/css/postcss/ (npm i -D postcss postcss-cli autoprefixer)"

help:
	@echo "Available commands:"
	@echo "  dev       - Start development server"
	@echo "  build     - Build for production"
	@echo "  deploy    - Deploy to Cloudflare pages"
	@echo "  new-post  - Create new blog post"
	@echo "  clean     - Remove public directory"
	@echo "  install   - Show installation instructions"
