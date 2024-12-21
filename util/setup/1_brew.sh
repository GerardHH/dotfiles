#!/bin/bash

export BREW_PREFIX=/home/linuxbrew/.linuxbrew

if [ -d $BREW_PREFIX ]; then
    if command -v brew; then
        echo "Skipping: Brew already setup"
        return 0
    fi

    echo "Success: Official brew installation found and sourced"
    source $WORK_DIR/source_brew.sh
    return 0
fi

echo "Warning: No brew installation found, installing rootless"

if ! dpkg-query -W -f='${status}\n' build-essential; then
    echo "Error: build-essential not installed"
    return 1
fi

check_dependencies curl git ps

BREW_PREFIX=$HOME/.linuxbrew/Homebrew
if [ ! -d $BREW_PREFIX ]; then
    git clone --depth=1 https://github.com/Homebrew/brew $BREW_PREFIX
fi
