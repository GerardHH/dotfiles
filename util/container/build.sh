#!/bin/bash

REPO_PATH="${REPO_PATH:-$HOME/dotfiles}"

podman build -t dotfiles-test:latest $REPO_PATH -f util/container/Dockerfile
podman build -t dotfiles-pre-installed-test:latest $REPO_PATH -f util/container/pre_installed.Dockerfile
