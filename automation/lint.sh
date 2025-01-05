#!/bin/bash

REPO_PATH="${REPO_PATH:-${HOME}/dotfiles}"

source "${REPO_PATH}"/automation/util.sh

if [[ -z "${AUTO_DIR}" ]]; then
	echo "Error: AUTO_DIR not set"
	exit 1
fi

source "${AUTO_DIR}"/source_brew.sh

if ! command -v shellcheck; then
	echo "Warning: shellcheck not found, installing..."

	brew install shellcheck
fi

# Excluded checks:
# - SC1091: Not following. Can't figure out a nice way to resolve $HOME.
# - SC2312: Consider invoking this command separately to avoid masking its return value. Annoying.
find "${REPO_PATH}" -type f -name "*.sh" -exec shellcheck --enable=all --exclude=SC1091,SC2312 {} +
