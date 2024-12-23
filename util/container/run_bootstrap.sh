#!/bin/bash

set -ex

podman run \
	--entrypoint /bin/bash \
	--env-file .env \
	--rm \
	dotfiles-test \
	-c "./bootstrap.sh; ./dotfiles/util/validate.sh"
