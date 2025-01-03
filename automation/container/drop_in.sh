#!/bin/bash

CONTAINER_NAME="dotfiles-test:latest"
LOCAL_DIR="${HOME}/dotfiles"
CONTIANER_DIR="/home/testuser/dotfiles"

CONTAINER_ID=$(
	podman create \
		--env-file .env \
		--interactive \
		--tty \
		--rm \
		"${CONTAINER_NAME}" \
)

podman cp "${LOCAL_DIR}" "${CONTAINER_ID}":"${CONTIANER_DIR}"

podman start \
	--attach \
	--interactive \
	"${CONTAINER_ID}"
