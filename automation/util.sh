#!/bin/bash

export ROOT_DIR="${HOME}/dotfiles"
export HOME_DIR="${ROOT_DIR}/home"
export AUTO_DIR="${ROOT_DIR}/automation"
export LOG_DIR="${ROOT_DIR}/log"

source "${AUTO_DIR}/source_brew.sh"

brew_install() {
    if [[ "$#" -eq 0 ]]; then
        echo "Error: Nothing to install"
        echo "Usage: brew_install neovim fzf zoxide"
        return 2
    fi

    if ! command -v brew; then
        echo "Error: could not find brew, please set it up or source it"
        return 2
    fi

    local caller_info="$(caller 0)"
    local timestamp="$(date +"%Y-%m-%d %H:%M:%S")"
    local header="[${timestamp}][${caller_info}]"
    local output="$(brew install "$@" 2>&1)"
    local result=$?

    {
        echo ""
        echo "${header}"
        echo "${output}"
    } >> "${LOG_DIR}/homebrew.log"

    if [[ ${result} -ne 0 ]]; then
        echo "Error: Failed to install '$*', refer to '${header}' in '${LOG_DIR}/homebrew.log'"
    fi
}

execute_scripts() {
	if [[ "$#" -eq 0 ]]; then
		echo "Error: No folder provided"
		echo "Usage: execute_scripts <folder>"
		return 2
	fi

	local scripts_dir=$1

	echo "Run scripts in '${scripts_dir}'"

	for script in "${scripts_dir}"/*; do
		echo "" # New line for my dyslexic ass
		echo "----- ${script} -----"

		if [[ ! -x "${script}" ]]; then
			echo "Skipping: Not executable"
			continue
		fi

		if [[ ! -f "${script}" ]]; then
			echo "Skipping: Not a regular file"
			continue
		fi

		# Gave this error on the work laptop, even though the permisions seem to be 755
		#if [[ "$(stat -c '%a' "${script}")" -gt 755 ]]; then
		#echo "Skipping: Unsafe permissions"
		#continue
		#fi

        # Run in "isolated" subshell
        (
            "${script}"
        )

		RESULT=$?
		if [[ "${RESULT}" -ne 0 ]]; then
			echo "----- Failed: ${RESULT} -----"
		else
			echo "----- Success! -----"
		fi
	done
}
