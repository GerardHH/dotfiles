#!/bin/sh

BREW_PREFIX=/home/linuxbrew/.linuxbrew/Homebrew

if [ ! -d $BREW_PREFIX ]; then
	BREW_PREFIX=$HOME/.linuxbrew/Homebrew
fi

export PATH="$BREW_PREFIX/bin:$BREW_PREFIX/sbin:$PATH"
eval "$($BREW_PREFIX/bin/brew shellenv)"
