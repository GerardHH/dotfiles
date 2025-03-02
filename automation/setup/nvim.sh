#!/bin/bash

CPP_LS=("llvm")
LUA_LS=("lua-language-server" "stylua")
MARKDOWN_LS=("marksman")
SHELL_LS=("bash-language-server" "shellcheck" "shfmt")
PYTHON_LS=("pyright" "ruff" "mypy")

OTHER_DEPS=("fzf" "lazygit" "ripgrep" "yazi")

if [[ -z "${HOME_DIR}" ]]; then
	echo "Error: HOME_DIR not set"
	exit 2
fi

NVIM_DIR="${HOME_DIR}/.config/nvim"

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

if [[ -z "${AUTO_DIR}" ]]; then
	echo "Error: AUTO_DIR not set"
	exit 2
fi

source "${AUTO_DIR}/source_brew.sh"

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
		"${MARKDOWN_LS[@]}" \
		"${SHELL_LS[@]}" \
		"${PYTHON_LS[@]}" \
		"${OTHER_DEPS[@]}"
else
	echo "Nvim already installed"
fi
