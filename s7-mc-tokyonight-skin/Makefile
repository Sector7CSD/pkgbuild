# Ziel-Paketdatei
PKG_FILE := $(shell makepkg --packagelist | xargs basename)

# Baue das Paket, wenn das PKGBUILD oder Dateien in src geändert wurden
$(PKG_FILE): PKGBUILD $(wildcard src/*)
	makepkg -sf

# Standardziel zum Paketbau
all: $(PKG_FILE)

clean:
	rm -rf *.pkg.tar.zst ./pkg
