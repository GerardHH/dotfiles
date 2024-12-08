set -ex

podman run --rm --entrypoint /bin/sh dotfiles-test -c "./setup.sh; ./validate.sh"
