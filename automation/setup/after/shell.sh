#!/bin/bash

#shellcheck source=./automation/util.sh
source "${HOME}/dotfiles/automation/util.sh"

if ! command -v zsh; then
	log_error "zsh not found"
	exit 1
fi

log_info "Source .zshrc"
if ! zsh -c "source ${HOME}/.zshrc"; then
	log_error "zsh did not source .zshrc without problems"
	exit 1
fi
# Make sure there's a new line at end of this scripts output
# util.sh::execute_scripts expects that
echo ""
