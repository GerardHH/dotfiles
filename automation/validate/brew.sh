#!/bin/bash

if [[ -z "${AUTO_DIR}" ]]; then
    echo "Error: AUTO_DIR not set"
    exit 1
fi

if [[ -f "${AUTO_DIR}"/.env ]]; then
	source "${AUTO_DIR}"/.env
fi

source "${AUTO_DIR}"/source_brew.sh

if ! command -v brew && brew install hello && hello; then
	echo "Failed to detect brew, install or run hello program"
	exit 1
fi
