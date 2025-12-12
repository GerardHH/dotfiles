#!/bin/bash

#shellcheck source=./automation/util.sh
source "${HOME}/dotfiles/automation/util.sh"

if ! command -v rgrep; then
	log_error "Could not find ripgrep"
	exit 1
fi

if [[ ! -L "${HOME}/.config/ripgrep" ]]; then
	log_error "ripgrep config not deployed"
	exit 1
fi
