#!/bin/bash

if command -v brew; then
	echo "Skipping: Brew already setup"
	exit 0
fi

export BREW_PREFIX=/home/linuxbrew/.linuxbrew

if [[ ! -d "${BREW_PREFIX}" ]]; then
	log_error "brew not installed, please use official brew installation"
	exit 1
fi

#shellcheck source=./automation/util.sh
source "${HOME}/dotfiles/automation/util.sh"

echo "Setup Perl dependencies"
if ! command -v cpanm; then
	echo "No cpanm found, installing..."
	brew_install cpanm
fi
cpanm IPC::Cmd
