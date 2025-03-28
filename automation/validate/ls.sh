#!/bin/bash

#shellcheck source=./automation/util.sh
source "${HOME}/dotfiles/automation/util.sh"

# CPP
if ! command -v clangd || ! command -v clang-format; then
	log_error "Could not find clangd or clang-format"
	exit 1
fi

# LUA
if ! command -v lua-language-server; then
	log_error "Could not find lua-language-server"
	exit 1
fi

if ! command -v stylua; then
	log_error "Could not find stylua"
	exit 1
fi

# Markdown
if ! command -v marksman; then
	log_error "Could not find marksman"
	exit 1
fi

# Shell
if ! command -v bash-language-server; then
	log_error "Could not find bash-language-server"
	exit 1
fi

if ! command -v shellcheck; then
	log_error "Could not find shellcheck"
	exit 1
fi

if ! command -v shfmt; then
	log_error "Could not find shfmt"
	exit 1
fi

# Python
if ! command -v pyright; then
	log_error "Could not find pyright"
	exit 1
fi

if ! command -v ruff; then
	log_error "Could not find ruff"
	exit 1
fi

if ! command -v mypy; then
	log_error "Could not find mypy"
	exit 1
fi
