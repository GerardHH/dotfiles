#!/bin/bash

# Use subshell to protect parent environment.
(
    export WORK_DIR=$(dirname "$(readlink -f "$0")")
    export REPO_ROOT=$(dirname "$WORK_DIR")
    export SCRIPTS_DIR=$WORK_DIR/setup

    source $WORK_DIR/util.sh
    echo "----- Start setup -----"
    execute_scripts $SCRIPTS_DIR
    echo "----- Finished setup -----"
)
