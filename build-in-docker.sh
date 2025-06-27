#!/bin/bash
# Datei: pkgbuild/build-in-docker.sh

set -e

pkgname="$1"
if [[ -z "$pkgname" ]]; then
  echo "Usage: $0 <pkgdir-name>"
  exit 1
fi

# In dem Verzeichnis landen .pkg.tar.zst etc.
build_dir="$(pwd)/${pkgname}"

docker build -f Dockerfile.makepkg -t arch-makepkg .

docker run --rm \
  -v "$build_dir":/home/builder/pkgbuild \
  -v "$HOME/.makepkg.conf":/home/builder/.makepkg.conf:ro \
  -v /var/cache/pacman/pkg:/var/cache/pacman/pkg:ro \
  -e MIRROR_URL="$MIRROR_URL" \
  arch-makepkg \
  bash -c ' \
    if [[ -n "$MIRROR_URL" ]]; then \
      echo "==> Using custom mirror: $MIRROR_URL"; \
      echo "Server = $MIRROR_URL" | sudo tee /etc/pacman.d/mirrorlist; \
    else \
      echo "==> Using default Arch mirrorlist"; \
    fi && \
    cd /home/builder/pkgbuild && makepkg -fs --noconfirm'
