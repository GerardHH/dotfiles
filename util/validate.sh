#!/bin/bash

# Use subshell to protect parent environment.
(
	source $HOME/dotfiles/util/util.sh
	SCRIPTS_DIR=$UTIL_DIR/validate

	echo "----- Start validation -----"
	execute_scripts "$SCRIPTS_DIR"
	echo "----- Finished validation -----"
)
