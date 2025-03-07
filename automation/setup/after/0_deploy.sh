#!/bin/bash

#shellcheck source=./automation/util.sh
source "${HOME}/dotfiles/automation/util.sh"

if ! command -v stow; then
    echo "Info: Cannot find stow, installing..."

    brew_install stow
fi

SOURCE="${ROOT_DIR}"/home
TARGET="${HOME}"

echo "Deploying from '${SOURCE}' to '${TARGET}'"

stow \
	--dir="${SOURCE}" \
	--target="${TARGET}" \
    --ignore="(\.gpg)" \
    --stow .
