#!/bin/bash

#shellcheck source=./automation/util.sh
source "${HOME}/dotfiles/automation/util.sh"

if ! command -v opencode; then
	log_error "Could not find opencode"
	exit 1
fi

ignore_file="${HOME}/.config/git/ignore"
keyword=".opencode"
if [[ -e "$ignore_file" ]]; then
	if ! grep --quiet "$keyword" "$ignore_file"; then
		log_error "$ignore_file: doesn't contain $keyword"
		exit 1
	fi
else
	log_error "'$ignore_file' doesn't exist"
	exit 1
fi
