# Makefile for Rust + Static Web Server
.DEFAULT_GOAL := run

CARGO ?= cargo
PORT ?= 8787
PUBLIC_DIR ?= public
INDEX ?= index.html

.PHONY: all build serve open run kill-server

kill-server:
	@lsof -ti tcp:$(PORT) | xargs -r kill || true

build:
	$(CARGO) build --release
	$(CARGO) run --bin pretty_print

serve: kill-server
	python3 -m http.server $(PORT) --directory $(PUBLIC_DIR) &
open:
	open http://localhost:$(PORT)/$(INDEX) &

run: build serve open
	@echo "Site is running at http://localhost:$(PORT)/$(INDEX)"

all: build serve open run
