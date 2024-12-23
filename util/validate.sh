#!/bin/bash

# Use subshell to protect parent environment.
(
	source "${HOME}"/dotfiles/util/util.sh

    if [[ -z "${UTIL_DIR}" ]]; then
        echo "Error: UTIL_DIR not set"
        exit 1
    fi

	SCRIPTS_DIR="${UTIL_DIR}"/validate

	echo "----- Start validation -----"
	execute_scripts "${SCRIPTS_DIR}"
	echo "----- Finished validation -----"
)
