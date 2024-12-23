#!/bin/bash

CPP_LS=("llvm")
LUA_LS=("lua-language-server")
SHELL_LS=("bash-language-server" "shellcheck" "shfmt")

OTHER_DEPS=("fzf" "lazygit" "yazi")

NVIM_DIR="${HOME}/.config/nvim"

if [[ ! -d "${NVIM_DIR}" ]]; then
	echo "Did not find '${NVIM_DIR}', creating and checking out..."

	if ! mkdir "${NVIM_DIR}"; then
		echo "Error: Could not create '${NVIM_DIR}'"
		exit 1
	fi

	if ! command -v git; then
		echo "Error: Cannot find git"
		exit 1
	fi

	if ! git clone https://github.com/GerardHH/nvim.git "${NVIM_DIR}"; then
		echo "Error: Could not clone into '${NVIM_DIR}'"
		exit 1
	fi
else
	echo "'${NVIM_DIR}' exists"
fi

if [[ -z "${UTIL_DIR}" ]]; then
	echo "Error: UTIL_DIR not set"
	exit 2
fi

if ! command -v nvim; then
	echo "Did not find nvim, installing + dependencies..."

	if ! command -v brew; then
		echo "Error: cannot find brew"
		exit 1
	fi

	brew install \
		neovim \
		"${CPP_LS[@]}" \
		"${LUA_LS[@]}" \
		"${SHELL_LS[@]}" \
		"${OTHER_DEPS[@]}"
else
	echo "Nvim already installed"
fi

if ! nvim --headless -c 'Lazy! install' -c 'quitall'; then
	echo "Error: Lazy did not install plugins"
	exit 1
fi
