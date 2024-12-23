#!/bin/bash

if [[ -z "${UTIL_DIR}" ]]; then
	echo "Error: UTIL_DIR not set"
	exit 2
fi

source "${UTIL_DIR}/source_brew.sh"

if ! command -v nvim; then
	echo "Error: Could not find nvim"
	exit 1
fi
