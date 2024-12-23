#!/bin/bash

REPO_PATH="${REPO_PATH:-${HOME}/dotfiles}"

if ! command -v shellcheck; then
    echo "Warning: shellcheck not found, installing..."

    source "${REPO_PATH}"/util/util.sh

    if [[ -z "${UTIL_DIR}" ]]; then
        echo "Error: UTIL_DIR not set"
        exit 1
    fi

    source "${UTIL_DIR}"/source_brew.sh
    brew install shellcheck
fi

# Excluded checks:
# - SC1091: Not following. Can't figure out a nice way to resolve $HOME.
# - SC2312: Consider invoking this command separately to avoid masking its return value. Annoying.
find "${REPO_PATH}" -type f -name "*.sh" -exec shellcheck --enable=all --exclude=SC1091,SC2312 {} +
