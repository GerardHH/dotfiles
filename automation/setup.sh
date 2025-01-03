#!/bin/bash

# Use subshell to protect parent environment.
(
	source "${HOME}/dotfiles/automation/util.sh"

	if [[ -z "${AUTO_DIR}" ]]; then
		echo "Error: AUTO_DIR not set"
		exit 1
	fi

	SCRIPTS_DIR="${AUTO_DIR}"/setup

	echo "----- Start setup -----"
	execute_scripts "${SCRIPTS_DIR}/before"
	execute_scripts "${SCRIPTS_DIR}"
	execute_scripts "${SCRIPTS_DIR}/after"
	echo "----- Finished setup -----"
)
