#!/bin/bash

#shellcheck source=./automation/util.sh
source "${HOME}/dotfiles/automation/util.sh"

if ! command -v lazygit; then
	log_error "Could not find lazygit"
	exit 1
fi

if [[ ! -L "${HOME}/.config/lazygit" ]]; then
	log_error "lazygit config not deployed"
	exit 1
fi
