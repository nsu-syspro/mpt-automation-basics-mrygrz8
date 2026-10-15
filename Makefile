NAME := $(shell jq -r .name config.json)
VERSION := $(shell jq -r .version config.json)

all: build/$(NAME)

build/$(NAME): src/wordcount.c config.json
	mkdir -p build
	gcc -DNAME='"$(NAME)"' -DVERSION='"$(VERSION)"' src/wordcount.c -o build/$(NAME)

check: build/$(NAME)
	@for file in test/*.txt; do \
		./build/$(NAME) "$$file" | diff -u "$${file%.txt}.expected" - || exit 1; \
	done

clean:
	rm -rf build

