#!/bin/bash

#shellcheck source=./automation/util.sh
source "${HOME}/dotfiles/automation/util.sh"

if ! command -v lazydocker; then
	echo "Error: Could not find lazydocker"
	exit 1
fi

if [[ ! -L "${HOME}/.config/lazydocker" ]]; then
	echo "Error: lazydocker config not deployed"
	exit 1
fi
