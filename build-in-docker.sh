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
  arch-makepkg \
  bash -c "cd /home/builder/pkgbuild && makepkg -fs --noconfirm && rm -f src/*.zip"
