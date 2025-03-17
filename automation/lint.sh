#!/bin/bash

#shellcheck source=./automation/util.sh
source "${HOME}/dotfiles/automation/util.sh"

if ! command -v shellcheck; then
	log_warning "shellcheck not found, installing..."

	brew_install shellcheck
fi

# Move to repo root, so that "shellcheck source=./automation/util.sh" can direct shellcheck on `source` commands
pushd "${ROOT_DIR}" || exit

# Excluded checks:
# - SC1091: Not following. Can't figure out a nice way to resolve $HOME.
# - SC2155: Declare and assign separately to avoid masking return values. Annoying.
# - SC2312: Consider invoking this command separately to avoid masking its return value. Annoying.
find . -type f -name "*.sh" -exec shellcheck --enable=all --exclude=SC1091,SC2155,SC2312 {} +

popd || exit
