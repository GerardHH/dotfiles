#!/bin/bash

#shellcheck source=./automation/util.sh
source "${HOME}/dotfiles/automation/util.sh"

if ! command -v btop; then
	log_error "Could not find btop"
	exit 1
fi

if ! command -v delta; then
	log_error "Could not find delta"
	exit 1
fi

if ! command -v fzf; then
	log_error "Could not find fzf"
	exit 1
fi

if ! command -v lazydocker; then
	log_error "Could not find lazydocker"
	exit 1
fi

if ! command -v lazygit; then
	log_error "Could not find lazygit"
	exit 1
fi

if ! command -v rg; then
	log_error "Could not find ripgrep"
	exit 1
fi

if ! command -v yazi; then
	log_error "Could not find yazi"
	exit 1
fi
