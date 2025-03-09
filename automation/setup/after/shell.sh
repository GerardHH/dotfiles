#!/bin/bash

#shellcheck source=./automation/util.sh
source "${HOME}/dotfiles/automation/util.sh"

if ! command -v zsh; then
	echo "Error: zsh not found"
	exit 1
fi

echo "Source .zshrc"
if ! zsh -c "source ${HOME}/.zshrc"; then
	echo "Error: zsh did not source .zshrc without problems"
	exit 1
fi
# Make sure there's a new line at end of this scripts output
# util.sh::execute_scripts expects that
echo ""
