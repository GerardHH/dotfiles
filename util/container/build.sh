#!/bin/bash

REPO_PATH="${REPO_PATH:-${HOME}/dotfiles}"

podman build -t dotfiles-test:latest "${REPO_PATH}" -f util/container/Dockerfile
