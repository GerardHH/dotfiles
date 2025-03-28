#!/bin/bash

#shellcheck source=./automation/util.sh
source "${HOME}/dotfiles/automation/util.sh"

NVIM_DIR="${HOME_DIR}/.config/nvim"

if [[ ! -d "${NVIM_DIR}" ]]; then
	log_info "Did not find '${NVIM_DIR}', creating and checking out..."

	if ! mkdir "${NVIM_DIR}"; then
		log_error "Could not create '${NVIM_DIR}'"
		exit 1
	fi

	if ! command -v git; then
		log_error "Cannot find git"
		exit 1
	fi

	if ! git clone https://github.com/GerardHH/nvim.git "${NVIM_DIR}"; then
		log_error "Could not clone into '${NVIM_DIR}'"
		exit 1
	fi
else
	log_info "'${NVIM_DIR}' exists"
fi

if ! command -v nvim; then
	log_info "Did not find nvim, installing + dependencies..."

	brew_install neovim

else
	log_info "Nvim already installed"
fi
