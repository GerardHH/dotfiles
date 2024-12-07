set -ex

podman run --rm --entrypoint /bin/sh dotfiles-pre-installed-test -c "./setup.sh; ./validate.sh"
