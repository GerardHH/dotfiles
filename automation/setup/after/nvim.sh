#!/bin/bash

if [[ -z "${AUTO_DIR}" ]]; then
	echo "Error: AUTO_DIR not set"
	exit 2
fi

source "${AUTO_DIR}/source_brew.sh"

if ! command -v nvim; then
    echo "Error: Did not find nvim"
    exit 1
fi

if [[ -z "${LOG_DIR}" ]]; then
	echo "Error: LOG_DIR not set"
	exit 1
fi

date >>"${LOG_DIR}/lazy.log"

echo "Install plugins"
if ! nvim --headless -c 'Lazy! install' -c 'quitall' >>"${LOG_DIR}/lazy.log"; then
	echo "Error: Lazy did not install plugins"
	exit 1
fi
