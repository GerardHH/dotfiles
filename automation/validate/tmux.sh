#!/bin/bash

if [[ -z "${AUTO_DIR}" ]]; then
	echo "Error: AUTO_DIR not set"
	exit 2
fi

source "${AUTO_DIR}/source_brew.sh"

if ! command -v tmux; then
	echo "Error: Could not find tmux"
	exit 1
fi

if [[ ! -L "${HOME}/.config/tmux" ]]; then
	echo "Error: tmux config not deployed"
	exit 1
fi
