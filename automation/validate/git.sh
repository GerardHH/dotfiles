#!/bin/bash

if ! command -v git; then
	echo "Error: git command not found"
	exit 1
fi

if [[ ! -L "${HOME}"/.gitconfig ]]; then
	echo "Error: .gitconfig not deployed"
	exit 1
fi

if [[ ! -f "${HOME}"/.gitconfig.private ]]; then
	echo "Error: .gitconfig.private not deployed"
	exit 1
fi

if [[ ! -f "${HOME}"/.gitconfig.lely ]]; then
	echo "Error: .gitconfig.lely not deployed"
	exit 1
fi
