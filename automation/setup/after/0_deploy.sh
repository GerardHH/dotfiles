#!/bin/bash

#shellcheck source=./automation/util.sh
source "${HOME}/dotfiles/automation/util.sh"

if ! command -v stow; then
	log_info "Cannot find stow, installing..."

	brew_install stow
fi

source_dir="${ROOT_DIR}"/home
target_dir="${HOME}"

log_info "Deploying from '${source_dir}' to '${target_dir}'"

stow_output=$(stow \
	--dir="${source_dir}" \
	--target="${target_dir}" \
	--ignore="(\.gpg)" \
	. \
	2>&1)

ignore_list="\.gpg"

if [[ -n "${stow_output}" ]]; then
	log_info "stow found conflicts"
	conflicts=$(echo "$stow_output" | awk -F 'over existing target ' '{print $2}' | awk '{print $1}')
	for file in ${conflicts}; do
		log_info "conflict: '${file}'"
		# If the file is in a folder, take the folder location instead to backup
		if [[ "${file}" == */* ]]; then
			file=$(dirname "${file}")
		fi
		full_path="${target_dir}/${file}"
		full_path_bak="${full_path}.bak"
		log_info "back up '$full_path' to '${full_path_bak}'"
		if ! mv "${full_path}" "${full_path_bak}"; then
			log_warning "Failed to move '$full_path' skipping"
			escaped_path=$(echo "${file}" | sed 's/\./\\./g')
			ignore_list="${ignore_list}|${escaped_path}"
		fi
	done
fi

log_info "run 'stow' with ignore list '${ignore_list}'"

if ! stow \
	--dir="${source_dir}" \
	--target="${target_dir}" \
	--ignore="(${ignore_list})" \
	.; then
	log_error "Running stow after backing up conflicts still failed"
	exit 1
fi
