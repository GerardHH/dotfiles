#!/bin/bash

#shellcheck source=./automation/util.sh
source "${HOME}/dotfiles/automation/util.sh"

if ! command -v yazi; then
	echo "Error: Could not find yazi"
	exit 1
fi

if [[ ! -L "${HOME}/.config/yazi" ]]; then
	echo "Error: yazi config not deployed"
	exit 1
fi
