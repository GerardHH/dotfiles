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

	brew_install \
		zsh \
        "${DEPS[@]}"
else
	echo "Zsh already installed"
fi

