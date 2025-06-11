.PHONY: dev build new-post clean

dev:
	hugo server -D --bind 0.0.0.0 --disableFastRender

build: clean
	hugo --minify

new-post:
	@read -p "Enter post slug: " slug; \
	hugo new posts/$(shell date +%Y)/$$slug.md

clean:
	rm -rf public/

install:
	@echo "Ensure Hugo is installed: https://gohugo.io/installation/"

help:
	@echo "Available commands:"
	@echo "  dev       - Start development server"
	@echo "  build     - Build for production"
	@echo "  new-post  - Create new blog post"
	@echo "  clean     - Remove public directory"
	@echo "  install   - Show installation instructions"
