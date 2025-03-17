#!/bin/bash

#shellcheck source=./automation/util.sh
source "${HOME}/dotfiles/automation/util.sh"

if ! command -v navi; then
	log_error "Could not find navi"
	exit 1
fi

if [[ ! -L "${HOME}/.config/navi" ]]; then
	log_error "navi config not deployed"
	exit 1
fi

if [[ ! -f "${HOME}/.config/navi/cheats/vectorv2.cheat" ]]; then
	log_error "vectorv2.cheat did not decrypt"
	exit 1
fi
