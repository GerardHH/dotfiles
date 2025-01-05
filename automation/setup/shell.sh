#!/bin/bash

DEPS=( \
    "eza" \
    "fzf" \
    "navi" \
    "oh-my-posh" \
    "tmux" \
    "zoxide" \
)

if [[ -z "${AUTO_DIR}" ]]; then
	echo "Error: AUTO_DIR not set"
	exit 2
fi

source "${AUTO_DIR}/source_brew.sh"

if ! command -v zsh; then
	echo "Did not find zsh, installing + dependencies..."

	if ! command -v brew; then
		echo "Error: cannot find brew"
		exit 1
	fi

	brew install \
		zsh \
        "${DEPS[@]}"
else
	echo "Zsh already installed"
fi

if [[ -z "${HOME_DIR}" ]]; then
	echo "Error: HOME_DIR not set"
	exit 2
fi

