#!/bin/bash

if ! command -v stow; then
    echo "Warning: Cannot find stow, installing..."

    if [[ -z "${AUTO_DIR}" ]]; then
        echo "Error: AUTO_DIR not set"
        exit 1
    fi

    source "${AUTO_DIR}"/source_brew.sh
    brew install stow
fi

if [[ -z "${ROOT_DIR}" ]]; then
    echo "Error: ROOT_DIR not set"
    exit 1
fi

SOURCE="${ROOT_DIR}"/home
TARGET="${HOME}"

echo "Deploying from '${SOURCE}' to '${TARGET}'"

stow \
	--dir "${SOURCE}" \
	--target "${TARGET}" \
    --stow .
