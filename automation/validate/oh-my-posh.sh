#!/bin/bash

#shellcheck source=./automation/util.sh
source "${HOME}/dotfiles/automation/util.sh"

if ! command -v oh-my-posh; then
	log_error "Could not find oh-my-posh"
	exit 1
fi

if [[ ! -L "${HOME}/.config/oh-my-posh" ]]; then
	log_error "oh-my-posh config not deployed"
	exit 1
fi
