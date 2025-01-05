#!/bin/bash

if [[ -z "${AUTO_DIR}" ]]; then
	echo "Error: AUTO_DIR not set"
	exit 2
fi

source "${AUTO_DIR}/source_brew.sh"

if ! command -v lazygit; then
	echo "Error: Could not find lazygit"
	exit 1
fi

if [[ ! -L "${HOME}/.config/lazygit" ]]; then
	echo "Error: lazygit config not deployed"
	exit 1
fi
