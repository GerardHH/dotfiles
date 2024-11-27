#!/bin/sh

set -ex

DIR=$(dirname "$(readlink -f "$0")")
. $DIR/source_brew.sh

command -v brew && \
	brew install hello && \
	hello

command -v chezmoi
test -d "$HOME/.local/share/chezmoi"
