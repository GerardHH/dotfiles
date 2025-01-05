#!/bin/bash

if [[ -z "${AUTO_DIR}" ]]; then
	echo "Error: AUTO_DIR not set"
	exit 2
fi

source "${AUTO_DIR}/source_brew.sh"

if ! command -v lazydocker; then
	echo "Error: Could not find lazydocker"
	exit 1
fi

if [[ ! -L "${HOME}/.config/lazydocker" ]]; then
	echo "Error: lazydocker config not deployed"
	exit 1
fi
