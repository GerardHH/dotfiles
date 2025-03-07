#!/bin/bash

#shellcheck source=./automation/util.sh
source "${HOME}/dotfiles/automation/util.sh"

if ! command -v zsh; then
    echo "Error: Could not find zsh"
    exit 1
fi

if [[ ! -L "${HOME}/.zshrc" ]]; then
    echo "Error: .zshrc not deployed"
    exit 1
fi

OUTPUT=$(zsh -c "source ${HOME}/.zshrc")
if [[ -n "${OUTPUT}" ]]; then
    echo "Error: sourcing .zshrc gave output:"
    echo "${OUTPUT}"
    exit 1
fi
