#!/bin/bash

if ! command -v stow; then
    echo "Warning: Cannot find stow, installing..."
    brew install stow
fi

SOURCE="$REPO_ROOT"/home
TARGET="$HOME"

echo "Deploying from '$SOURCE' to '$TARGET'"

stow \
	--dir "$SOURCE" \
	--target "$TARGET" \
    --stow .
