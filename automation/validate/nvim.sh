#!/bin/bash

#shellcheck source=./automation/util.sh
source "${HOME}/dotfiles/automation/util.sh"

if ! command -v nvim; then
	echo "Error: Could not find nvim"
	exit 1
fi

if [[ ! -L "${HOME}/.config/nvim" ]]; then
	echo "Error: .config/nvim not deployed"
	exit 1
fi

pushd "${HOME}/.config/nvim" || exit
if git remote -v | grep -e "^git@github"; then
	echo "Error: nvim repo's remote is not set to ssh"
	exit 1
fi
popd || exit
