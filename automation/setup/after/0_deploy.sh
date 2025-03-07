#!/bin/bash

#shellcheck source=./automation/util.sh
source "${HOME}/dotfiles/automation/util.sh"

if ! command -v stow; then
    echo "Info: Cannot find stow, installing..."

    brew install stow
fi

if [[ -z "${ROOT_DIR}" ]]; then
    echo "Error: ROOT_DIR not set"
    exit 2
fi

SOURCE="${ROOT_DIR}"/home
TARGET="${HOME}"

echo "Deploying from '${SOURCE}' to '${TARGET}'"

stow \
	--dir="${SOURCE}" \
	--target="${TARGET}" \
    --ignore="(\.gpg)" \
    --stow .
