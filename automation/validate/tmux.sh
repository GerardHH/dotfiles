#!/bin/bash

#shellcheck source=./automation/util.sh
source "${HOME}/dotfiles/automation/util.sh"

if ! command -v tmux; then
	log_error "Could not find tmux"
	exit 1
fi

if [[ ! -L "${HOME}/.config/tmux" ]]; then
	log_error "tmux config not deployed"
	exit 1
fi
