#!/bin/bash

export ROOT_DIR="${HOME}"/dotfiles
export UTIL_DIR="${ROOT_DIR}"/util

execute_scripts() {
	if [[ "$#" -eq 0 ]]; then
		echo "Error: No folder provided"
		echo "Usage: execute_scripts <folder>"
		return 2
	fi

	local scripts_dir=$1

    echo "Run scripts in '${scripts_dir}'"

	for script in "${scripts_dir}"/*; do
		echo "- ${script}:"

		if [[ ! -x "${script}" ]]; then
			echo "Skipping: Not executable"
			continue
		fi

		if [[ ! -f "${script}" ]]; then
			echo "Skipping: Not a regular file"
			continue
		fi

		if [[ "$(stat -c '%U' "${script}")" != "$(whoami)" ]]; then
			echo "Skipping: User executing this, doesn't own script"
			continue
		fi

		if [[ "$(stat -c '%a' "${script}")" -gt 755 ]]; then
			echo "Skipping: Unsafe permissions"
			continue
		fi

		"${script}"

		RESULT=$?
		if [[ "${RESULT}" -ne 0 ]]; then
			echo "Failed: ${RESULT}"
		else
			echo "Success!"
		fi
	done
}
