#!/bin/bash

REPO_PATH="${REPO_PATH:-${HOME}/dotfiles}"

CONTAINER_NAME="dotfiles-test:latest"
LOCAL_DIR="${HOME}/dotfiles"
CONTIANER_DIR="/home/testuser/dotfiles"

CONTAINER_ID=$(
	podman create \
		--env-file .env \
		--interactive \
		--tty \
		--rm \
		--entrypoint /bin/bash \
		"${CONTAINER_NAME}" \
		-c "${CONTIANER_DIR}/util/setup.sh; ${CONTIANER_DIR}/util/validate.sh"
)

podman cp "${LOCAL_DIR}" "${CONTAINER_ID}":"${CONTIANER_DIR}"

podman start \
	--attach \
	"${CONTAINER_ID}"
