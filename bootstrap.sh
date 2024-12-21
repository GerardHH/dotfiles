#!/bin/sh

BRANCH=set-up-git-config-files
SOURCE=https://github.com/GerardHH/dotfiles.git
TARGET=$HOME/dotfiles

git clone --branch "$BRANCH" "$SOURCE" "$TARGET"

"$TARGET"/util/setup.sh
