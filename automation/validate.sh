#!/bin/bash

source "${HOME}"/dotfiles/automation/util.sh

if [[ -z "${AUTO_DIR}" ]]; then
    log_error "AUTO_DIR not set"
    exit 1
fi

SCRIPTS_DIR="${AUTO_DIR}"/validate

log_info "----- Start validation -----"
execute_scripts "${SCRIPTS_DIR}"
log_info "----- Finished validation -----"
