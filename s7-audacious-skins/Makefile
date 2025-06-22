PKG_NAME := $(shell basename $(CURDIR))
PKG_FILE := $(shell makepkg --packagelist | xargs basename)

$(PKG_FILE): PKGBUILD
	cd .. && ./build-in-docker.sh $(PKG_NAME)

all: $(PKG_FILE)

clean:
	rm -rf *.pkg.tar.zst *.pkg.tar.zst.sig *.zip *.wsz ./pkg ./build ./src
