#!/bin/bash

BREW_PREFIX=/home/linuxbrew/.linuxbrew

if [ ! -d $BREW_PREFIX ]; then
	BREW_PREFIX=$HOME/.linuxbrew
fi

export PATH="$BREW_PREFIX/bin:$BREW_PREFIX/sbin:$PATH"
eval "$(brew shellenv)"

export HOMEBREW_NO_ENV_HINTS=1
