#!/bin/bash

if command -v brew; then
	echo "Skipping: Brew already setup"
	exit 0
fi

export BREW_PREFIX=/home/linuxbrew/.linuxbrew

if [[ ! -d "${BREW_PREFIX}" ]]; then
	echo "Error: brew not installed, please use official brew installation"
	exit 1
fi

if [[ -z "${AUTO_DIR}" ]]; then
    echo "Error: AUTO_DIR not set"
    exit 1
fi

echo "Source brew"
source "${AUTO_DIR}"/source_brew.sh

echo "Setup Perl dependencies"
if ! command -v cpanm; then
	echo "No cpanm found, installing..."
	brew install cpanm
fi
cpanm IPC::Cmd
