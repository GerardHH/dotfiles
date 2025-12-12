#!/bin/bash

#shellcheck source=./automation/util.sh
source "${HOME}/dotfiles/automation/util.sh"

# CPP
if ! command -v clangd || ! command -v clang-format; then
	brew_install llvm
fi

# LUA
if ! command -v lua-language-server; then
	brew_install lua-language-server
fi

if ! command -v stylua; then
	brew_install stylua
fi

# Markdown
if ! command -v marksman; then
	brew_install marksman
fi

# Shell
if ! command -v bash-language-server; then
	brew_install bash-language-server
fi

if ! command -v shellcheck; then
	brew_install shellcheck
fi

if ! command -v shfmt; then
	brew_install shfmt
fi

# Python
if ! command -v pyright; then
	brew_install pyright
fi

if ! command -v ruff; then
	brew_install ruff
fi

if ! command -v mypy; then
	brew_install mypy
fi
