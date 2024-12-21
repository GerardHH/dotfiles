#!/bin/bash

podman run \
	--env-file .env \
	--rm \
	-it \
	-v $(pwd)/util:/home/testuser/util \
	dotfiles-pre-installed-test:latest \
	bash
