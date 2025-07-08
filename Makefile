# Makefile for Rust + Static Web Server

CARGO ?= cargo
PORT ?= 8787
PUBLIC_DIR ?= public
INDEX ?= index.html

.PHONY: build serve open run

build:
	$(CARGO) build --release
	$(CARGO) run --bin pretty_print

serve:
	python3 -m http.server $(PORT) --directory $(PUBLIC_DIR) &

open:
	open http://localhost:$(PORT)/$(INDEX) &

run:
	$(MAKE) build
	@echo "Starting static file server at http://localhost:$(PORT)/$(INDEX) ..."
	open http://localhost:$(PORT)/$(INDEX) &
	python3 -m http.server $(PORT) --directory $(PUBLIC_DIR)
