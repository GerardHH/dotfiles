#!/bin/bash

#shellcheck source=./automation/util.sh
source "${HOME}/dotfiles/automation/util.sh"

if ! command -v stow; then
	echo "Info: Cannot find stow, installing..."

	brew_install stow
fi

source_dir="${ROOT_DIR}"/home
target_dir="${HOME}"

echo "Info: Deploying from '${source_dir}' to '${target_dir}'"

stow_output=$(stow \
	--dir="${source_dir}" \
	--target="${target_dir}" \
	--ignore="(\.gpg)" \
	. \
	2>&1)

if [[ -n "${stow_output}" ]]; then
	echo "Info: stow found conflicts"
	conflicts=$(echo "$stow_output" | awk -F 'over existing target ' '{print $2}' | awk '{print $1}')
	for file in ${conflicts}; do
		echo "Info: conflict: '${file}'"
		# If the file is in a folder, take the folder location instead to backup
		if [[ "${file}" == */* ]]; then
			file=$(dirname "${file}")
		fi
		full_path="${target_dir}/${file}"
		full_path_bak="${full_path}.bak"
		echo "Info: back up '$full_path' to '${full_path_bak}'"
		if ! mv "${full_path}" "${full_path_bak}"; then
			echo "Error: Failed to move '$full_path' to '${full_path_bak}'"
			exit 1
		fi
	done
fi

if ! stow \
	--dir="${source_dir}" \
	--target="${target_dir}" \
	--ignore="(\.gpg)" \
	. \
	2>&1; then
	echo "Error: Running stow after backing up conflicts still failed"
	exit 1
fi
