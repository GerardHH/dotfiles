#!/bin/bash

set -ex

podman run \
	--entrypoint /bin/sh \
	--env-file .env \
	--rm \
	dotfiles-test \
	-c "./bootstrap.sh; ./dotfiles/util/validate.sh"
