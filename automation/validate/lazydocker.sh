#!/bin/bash

#shellcheck source=./automation/util.sh
source "${HOME}/dotfiles/automation/util.sh"

if ! command -v lazydocker; then
	log_error "Could not find lazydocker"
	exit 1
fi

if [[ ! -L "${HOME}/.config/lazydocker" ]]; then
	log_error "lazydocker config not deployed"
	exit 1
fi
