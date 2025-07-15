#!/bin/bash

#shellcheck source=./automation/util.sh
source "${HOME}/dotfiles/automation/util.sh"

brew_install \
	btop \
	delta \
	fzf \
	lazydocker \
	lazygit \
	less \
	ripgrep \
	sst/tap/opencode \
	yazi
