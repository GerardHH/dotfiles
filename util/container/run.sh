#!/bin/bash

REPO_PATH="${REPO_PATH:-${HOME}/dotfiles}"

podman run \
	--entrypoint /bin/bash \
	--env-file .env \
	--rm \
	-v "${REPO_PATH}":/home/testuser/dotfiles \
	dotfiles-test:latest \
	-c "./dotfiles/util/setup.sh; ./dotfiles/util/validate.sh"
