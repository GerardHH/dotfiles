#!/bin/bash

if [[ -z "${AUTO_DIR}" ]]; then
	echo "Error: AUTO_DIR not set"
	exit 2
fi

source "${AUTO_DIR}/source_brew.sh"

if ! command -v btop; then
	echo "Error: Could not find btop"
	exit 1
fi

if [[ ! -L "${HOME}/.config/btop" ]]; then
	echo "Error: btop config not deployed"
	exit 1
fi
