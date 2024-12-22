#!/bin/bash

if ! command -v git; then
    echo "Error: git command not found"
    return 1
fi

if [ ! -L "$HOME"/.gitconfig ]; then
    echo "Error: .gitconfig not deployed"
    return 1
fi
