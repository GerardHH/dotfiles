#!/bin/bash

BREW_PREFIX=/home/linuxbrew/.linuxbrew

if [[ ! -d "${BREW_PREFIX}" ]]; then
	echo "Error: Cannot find brew installation, please install using the official way"
	exit 1
fi

export PATH="${BREW_PREFIX}/bin:${BREW_PREFIX}/sbin:${PATH}"
eval "$(brew shellenv)"

export HOMEBREW_NO_ENV_HINTS=1
