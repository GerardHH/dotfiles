#!/bin/bash

#shellcheck source=./automation/util.sh
source "${HOME}/dotfiles/automation/util.sh"

if ! command -v lazygit; then
	echo "Error: Could not find lazygit"
	exit 1
fi

if [[ ! -L "${HOME}/.config/lazygit" ]]; then
	echo "Error: lazygit config not deployed"
	exit 1
fi
