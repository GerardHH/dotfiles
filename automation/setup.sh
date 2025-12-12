#!/bin/bash

#shellcheck source=./automation/util.sh
source "${HOME}/dotfiles/automation/util.sh"

SCRIPTS_DIR="${AUTO_DIR}"/setup

log_info "----- Start setup -----"
execute_scripts "${SCRIPTS_DIR}/before"
execute_scripts "${SCRIPTS_DIR}"
execute_scripts "${SCRIPTS_DIR}/after"
log_info "----- Finished setup -----"
