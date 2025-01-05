#!/bin/bash

REPO_PATH="${REPO_PATH:-${HOME}/dotfiles}"

CONTAINER_NAME="dotfiles-test:latest"
CONTIANER_DIR="/home/testuser/dotfiles"

CONTAINER_ID=$(
	podman create \
		--env-file .env \
		--interactive \
		--tty \
		--rm \
		--entrypoint /bin/bash \
		"${CONTAINER_NAME}" \
		-c "${CONTIANER_DIR}/automation/setup.sh; ${CONTIANER_DIR}/automation/validate.sh"
)

podman cp "${REPO_PATH}" "${CONTAINER_ID}":"${CONTIANER_DIR}"

podman start \
	--attach \
	"${CONTAINER_ID}"
