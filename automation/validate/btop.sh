#!/bin/bash

#shellcheck source=./automation/util.sh
source "${HOME}/dotfiles/automation/util.sh"

if ! command -v btop; then
	log_error "Could not find btop"
	exit 1
fi

if [[ ! -L "${HOME}/.config/btop" ]]; then
	log_error "btop config not deployed"
	exit 1
fi
