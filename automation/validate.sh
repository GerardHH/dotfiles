#!/bin/bash

source "${HOME}"/dotfiles/automation/util.sh

if [[ -z "${AUTO_DIR}" ]]; then
    echo "Error: AUTO_DIR not set"
    exit 1
fi

SCRIPTS_DIR="${AUTO_DIR}"/validate

echo "----- Start validation -----"
execute_scripts "${SCRIPTS_DIR}"
echo "----- Finished validation -----"
