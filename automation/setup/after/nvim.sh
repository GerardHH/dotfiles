#!/bin/bash

#shellcheck source=./automation/util.sh
source "${HOME}/dotfiles/automation/util.sh"

if ! command -v nvim; then
	log_error "Did not find nvim"
	exit 1
fi

log_info "Install plugins"
if ! nvim --headless -c 'Lazy! install' -c 'quitall'; then
	log_error "Lazy did not install plugins"
	exit 1
fi
