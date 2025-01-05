#!/bin/bash

if [[ -z "${AUTO_DIR}" ]]; then
	echo "Error: AUTO_DIR not set"
	exit 2
fi

source "${AUTO_DIR}/source_brew.sh"

if ! command -v navi; then
	echo "Error: Could not find navi"
	exit 1
fi

if [[ ! -L "${HOME}/.config/navi" ]]; then
	echo "Error: navi config not deployed"
	exit 1
fi

if [[ ! -f "${HOME}/.config/navi/cheats/vectorv2.cheat" ]]; then
	echo "Error: vectorv2.cheat did not decrypt"
	exit 1
fi
