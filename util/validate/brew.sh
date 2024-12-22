#!/bin/bash

source "$UTIL_DIR/source_brew.sh"

if ! command -v brew && brew install hello && hello; then
	echo "Failed to detect brew, install or run hello program"
	exit 1
fi
