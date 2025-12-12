#!/bin/bash

#shellcheck source=./automation/util.sh
source "${HOME}/dotfiles/automation/util.sh"

if ! command -v nvim; then
	log_error "Could not find nvim"
	exit 1
fi

if [[ ! -L "${HOME}/.config/nvim" ]]; then
	log_error ".config/nvim not deployed"
	exit 1
fi

pushd "${HOME}/.config/nvim" || exit
if git remote -v | grep -e "^git@github"; then
	log_error "nvim repo's remote is not set to ssh"
	exit 1
fi
popd || exit
