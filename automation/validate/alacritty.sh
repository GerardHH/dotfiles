#!/bin/bash

if ! command -v alacritty; then
	echo "Warning: Could not find alacritty, consider installing it using host app manager"
fi

if [[ ! -L "${HOME}/.config/alacritty" ]]; then
	echo "Error: Alacritty config not deployed"
	exit 1
fi
