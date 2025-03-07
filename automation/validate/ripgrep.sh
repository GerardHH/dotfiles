#!/bin/bash

#shellcheck source=./automation/util.sh
source "${HOME}/dotfiles/automation/util.sh"

if ! command -v rgrep; then
	echo "Error: Could not find ripgrep"
	exit 1
fi

if [[ ! -L "${HOME}/.config/ripgrep" ]]; then
	echo "Error: ripgrep config not deployed"
	exit 1
fi
