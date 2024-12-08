#!/bin/sh

podman run --rm -it -v $(pwd)/util:/home/testuser/util dotfiles-pre-installed-test:latest bash
