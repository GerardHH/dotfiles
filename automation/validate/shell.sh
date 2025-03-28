#!/bin/bash

#shellcheck source=./automation/util.sh
source "${HOME}/dotfiles/automation/util.sh"

if ! command -v zsh; then
	log_error "Could not find zsh"
	exit 1
fi

if [[ ! -L "${HOME}/.zshrc" ]]; then
	log_error ".zshrc not deployed"
	exit 1
fi

OUTPUT=$(zsh -c "source ${HOME}/.zshrc")
if [[ -n "${OUTPUT}" ]]; then
	log_error "sourcing .zshrc gave output:"
	log_error "${OUTPUT}"
	exit 1
fi
