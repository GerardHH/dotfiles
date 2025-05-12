#!/bin/bash

DEPS=(
	"eza"
	"fzf"
	"navi"
	"oh-my-posh"
	"tmux"
	"zoxide"
)

#shellcheck source=./automation/util.sh
source "${HOME}/dotfiles/automation/util.sh"

brew_install "${DEPS[@]}"

FZF_TAB_COMPLETION_DIR="$HOME_DIR/.config/bash/fzf"
if [ ! -d "$FZF_TAB_COMPLETION_DIR" ]; then
	git clone git@github.com:lincheney/fzf-tab-completion.git "$FZF_TAB_COMPLETION_DIR"
fi
