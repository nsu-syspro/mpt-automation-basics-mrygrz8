SHELL := /bin/bash
NAME := $(shell jq -r .name config.json)
VERSION := $(shell jq -r .version config.json)
TESTS := $(wildcard test/*.txt)

all: build/$(NAME)

build/$(NAME): src/wordcount.c config.json
	@mkdir -p build
	@gcc -DNAME='"$(NAME)"' -DVERSION='"$(VERSION)"' src/wordcount.c -o build/$(NAME)


check: $(TESTS:.txt=.check)
test/%.check: test/%.txt test/%.expected build/$(NAME)
	@./build/$(NAME) $< | diff -u test/$*.expected -

clean:
	rm -rf build

