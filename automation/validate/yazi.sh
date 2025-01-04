#!/bin/bash

if [[ -z "${AUTO_DIR}" ]]; then
	echo "Error: AUTO_DIR not set"
	exit 2
fi

source "${AUTO_DIR}/source_brew.sh"

if ! command -v yazi; then
	echo "Error: Could not find yazi"
	exit 1
fi

if [[ ! -L "${HOME}/.config/yazi" ]]; then
	echo "Error: yazi config not deployed"
	exit 1
fi
