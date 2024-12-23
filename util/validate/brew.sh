#!/bin/bash

if [[ -z "${UTIL_DIR}" ]]; then
    echo "Error: UTIL_DIR not set"
    exit 1
fi

if [[ -f "${UTIL_DIR}"/.env ]]; then
	source "${UTIL_DIR}"/.env
fi

source "${UTIL_DIR}"/source_brew.sh

if ! command -v brew && brew install hello && hello; then
	echo "Failed to detect brew, install or run hello program"
	exit 1
fi
