.PHONY: rb objc lua all clean

OUTDIR ?= ./lib
PB_NO_TAG_WARNINGS := 1

install:
	git submodule update --init --recursive && \
	cd vendor/protobuf-objc && \
	./scripts/build.sh

# objc
objc.in:
	mkdir -p ./build/objc
	cat ./definitions/velocity.objc.proto > ./build/objc/velocity.proto
	cat ./definitions/velocity.proto >> ./build/objc/velocity.proto

objc: objc.in
	mkdir -p $(OUTDIR)/objc
	protoc -I ./build/objc -I ./vendor/protobuf-objc/src/compiler/ --objc_out=$(OUTDIR)/objc ./build/objc/velocity.proto

# golang
golang.in:
	mkdir -p ./build/golang
	cp ./definitions/velocity.proto ./build/golang/velocity.proto

golang: golang.in
	mkdir -p $(OUTDIR)/golang
	protoc -I ./build/golang --go_out=$(OUTDIR)/golang ./build/golang/velocity.proto

clean:
	rm -rf ./build

all: objc golang