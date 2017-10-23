.PHONY: rb objc lua all clean

OUTDIR ?= ./lib

# objc
objc:
	mkdir -p $(OUTDIR)/objc
	protoc -I ./definitions --objc_out=$(OUTDIR)/objc ./definitions/velocity.proto

# golang
golang:
	mkdir -p $(OUTDIR)/golang
	protoc -I ./definitions --go_out=$(OUTDIR)/golang ./definitions/velocity.proto

clean:
	rm -rf ./build

all: objc golang