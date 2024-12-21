#!/bin/bash

# Use subshell to protect parent environment.
(
	export WORK_DIR=$(dirname "$(readlink -f "$0")")
	export SCRIPTS_DIR=$WORK_DIR/validate

	source "$WORK_DIR"/util.sh
	echo "----- Start validation -----"
	execute_scripts "$SCRIPTS_DIR"
	echo "----- Finished validation -----"
)
