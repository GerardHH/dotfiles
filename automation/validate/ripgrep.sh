#!/bin/bash

if [[ -z "${AUTO_DIR}" ]]; then
	echo "Error: AUTO_DIR not set"
	exit 2
fi

source "${AUTO_DIR}/source_brew.sh"

if ! command -v rgrep; then
	echo "Error: Could not find ripgrep"
	exit 1
fi

if [[ ! -L "${HOME}/.config/ripgrep" ]]; then
	echo "Error: ripgrep config not deployed"
	exit 1
fi
