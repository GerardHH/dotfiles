#!/bin/bash

#shellcheck source=./automation/util.sh
source "${HOME}/dotfiles/automation/util.sh"

if ! command -v stow; then
	echo "Error: Cannot find stow"
	exit 1
fi

source_dir="${ROOT_DIR}"/home
target_dir="${HOME}"

if ! stow \
	--dir="${source_dir}" \
	--target="${target_dir}" \
	--ignore="(\.gpg)" \
	. \
	2>&1; then
	echo "Error: stow could not run without problems"
	exit 1
fi

if [[ -e "${target_dir}/.gitconfig.bak" ]]; then
	echo "Error: Failed to create a backup for the conflicting file '.gitconfig'"
fi

if [[ -e "${target_dir}/.config/nvim.bak" ]]; then
	echo "Error: Failed to create a backup for the conflicting folder '.config/nvim'"
fi
