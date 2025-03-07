#!/bin/bash

#shellcheck source=./automation/util.sh
source "${HOME}/dotfiles/automation/util.sh"

source "${AUTO_DIR}/source_brew.sh"

brew install \
	btop \
	delta \
	lazydocker
