#!/bin/bash

podman run \
	--env-file .env \
	--rm \
	-it \
	-v "${HOME}"/dotfiles:/home/testuser/dotfiles \
	dotfiles-test:latest \
	bash
