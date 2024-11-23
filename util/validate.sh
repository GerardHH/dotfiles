#!/bin/bash

# Use subshell to protect parent environment.
(
	export WORK_DIR=$(dirname "$(readlink -f "$0")")
	export SCRIPTS_DIR=$WORK_DIR/validate

	if [ -f $WORK_DIR/.env ]; then
		source $WORK_DIR/.env
	fi

	source "$WORK_DIR"/util.sh
	echo "----- Start validation -----"
	execute_scripts "$SCRIPTS_DIR"
	echo "----- Finished validation -----"
)
