#!/bin/bash

#shellcheck source=./automation/util.sh
source "${HOME}/dotfiles/automation/util.sh"

if ! command -v brew && brew install hello && hello; then
	log_error "Failed to detect brew, install or run hello program"
	exit 1
fi
