#!/bin/bash

if ! command -v git; then
	log_error "git command not found"
	exit 1
fi

if [[ ! -L "${HOME}"/.gitconfig ]]; then
	log_error ".gitconfig not deployed"
	exit 1
fi

if [[ ! -L "${HOME}"/.gitconfig.private ]]; then
	log_error ".gitconfig.private not deployed"
	exit 1
fi

if [[ ! -L "${HOME}"/.gitconfig.lely ]]; then
	log_error ".gitconfig.lely not deployed"
	exit 1
fi
