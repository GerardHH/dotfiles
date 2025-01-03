#!/bin/bash

if [[ -z "${AUTO_DIR}" ]]; then
	echo "Error: AUTO_DIR not set"
	exit 2
fi

source "${AUTO_DIR}/source_brew.sh"

if ! command -v zsh; then
    echo "Error: zsh not found"
    exit 1
fi

echo "Source .zshrc"
if ! zsh -c "source ${HOME}/.zshrc"; then
    echo "Error: zsh did not source .zshrc without problems"
    exit 1
fi
