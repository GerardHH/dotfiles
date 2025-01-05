#!/bin/bash

if [[ -z "${AUTO_DIR}" ]]; then
	echo "Error: AUTO_DIR not set"
	exit 2
fi

source "${AUTO_DIR}/source_brew.sh"

if ! command -v oh-my-posh; then
	echo "Error: Could not find oh-my-posh"
	exit 1
fi

if [[ ! -L "${HOME}/.config/oh-my-posh" ]]; then
	echo "Error: oh-my-posh config not deployed"
	exit 1
fi
