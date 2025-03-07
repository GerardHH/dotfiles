#!/bin/bash

#shellcheck source=./automation/util.sh
source "${HOME}/dotfiles/automation/util.sh"

if ! command -v nvim; then
	echo "Error: Did not find nvim"
	exit 1
fi

date >>"${LOG_DIR}/lazy.log"

echo "Install plugins"
if ! nvim --headless -c 'Lazy! install' -c 'quitall' >>"${LOG_DIR}/lazy.log"; then
	echo "Error: Lazy did not install plugins"
	exit 1
fi
