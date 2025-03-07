#!/bin/bash

DEPS=( \
    "eza" \
    "fzf" \
    "navi" \
    "oh-my-posh" \
    "tmux" \
    "zoxide" \
)

#shellcheck source=./automation/util.sh
source "${HOME}/dotfiles/automation/util.sh"

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

