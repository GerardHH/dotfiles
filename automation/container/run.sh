#!/bin/bash

REPO_PATH="${REPO_PATH:-${HOME}/dotfiles}"

CONTAINER_NAME="dotfiles-test:latest"
CONTIANER_DIR="/home/testuser/dotfiles"

echo "Create container '${CONTAINER_NAME}'"
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

if [[ -z "${CONTAINER_ID}" ]]; then
    echo "Could not create container '${CONTAINER_NAME}', does it exist?"
    exit 1
fi

echo "Copy '${REPO_PATH}' into '${CONTAINER_ID}:${CONTIANER_DIR}'"
podman cp "${REPO_PATH}" "${CONTAINER_ID}":"${CONTIANER_DIR}"

echo "Start container '${CONTAINER_ID}'"
podman start \
	--attach \
	"${CONTAINER_ID}"
