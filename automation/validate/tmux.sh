#!/bin/bash

#shellcheck source=./automation/util.sh
source "${HOME}/dotfiles/automation/util.sh"

if ! command -v tmux; then
	echo "Error: Could not find tmux"
	exit 1
fi

if [[ ! -L "${HOME}/.config/tmux" ]]; then
	echo "Error: tmux config not deployed"
	exit 1
fi
