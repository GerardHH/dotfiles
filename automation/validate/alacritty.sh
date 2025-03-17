#!/bin/bash

if ! command -v alacritty; then
	log_warning "Could not find alacritty, consider installing it using host app manager"
fi

if [[ ! -L "${HOME}/.config/alacritty" ]]; then
	log_error "Alacritty config not deployed"
	exit 1
fi
