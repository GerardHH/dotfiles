#!/bin/bash

BREW_PREFIX=/home/linuxbrew/.linuxbrew

if [[ ! -d "${BREW_PREFIX}" ]]; then
	echo "Cannot find brew installation, please install using the official way"
	exit 1
fi

BREW_PATHS="${BREW_PREFIX}/bin:${BREW_PREFIX}/sbin"

if [[ "${PATH}" != *"${BREW_PATHS}"* ]]; then
	export PATH="${BREW_PREFIX}/bin:${BREW_PREFIX}/sbin:${PATH}"
	eval "$(brew shellenv)"

	# HACK If init process is not systemd, assume we're in a container
	# Prefer applications installed by container over those of linuxbrew
	if [ "$(ps -p 1 -o comm=)" != "systemd" ]; then
		export PATH=/usr/bin:${PATH}
	fi

	export HOMEBREW_NO_ENV_HINTS=1
fi
