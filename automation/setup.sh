#!/bin/bash

# Use subshell to protect parent environment.
(
    #shellcheck source=./automation/util.sh
	source "${HOME}/dotfiles/automation/util.sh"

	SCRIPTS_DIR="${AUTO_DIR}"/setup

	echo "----- Start setup -----"
	execute_scripts "${SCRIPTS_DIR}/before"
	execute_scripts "${SCRIPTS_DIR}"
	execute_scripts "${SCRIPTS_DIR}/after"
	echo "----- Finished setup -----"
)
