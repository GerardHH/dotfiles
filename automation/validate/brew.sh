#!/bin/bash

#shellcheck source=./automation/util.sh
source "${HOME}/dotfiles/automation/util.sh"

if [[ -f "${AUTO_DIR}"/.env ]]; then
	source "${AUTO_DIR}"/.env
fi

if ! command -v brew && brew install hello && hello; then
	echo "Failed to detect brew, install or run hello program"
	exit 1
fi
