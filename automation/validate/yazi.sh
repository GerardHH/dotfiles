#!/bin/bash

#shellcheck source=./automation/util.sh
source "${HOME}/dotfiles/automation/util.sh"

if ! command -v yazi; then
	log_error "Could not find yazi"
	exit 1
fi

if [[ ! -L "${HOME}/.config/yazi" ]]; then
	log_error "yazi config not deployed"
	exit 1
fi
