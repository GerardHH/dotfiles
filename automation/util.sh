#!/bin/bash

export ROOT_DIR="${HOME}/dotfiles"
export HOME_DIR="${ROOT_DIR}/home"
export AUTO_DIR="${ROOT_DIR}/automation"

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

    brew install "$@"
}

execute_scripts() {
	if [[ "$#" -eq 0 ]]; then
		echo "Error: No folder provided"
		echo "Usage: execute_scripts <folder>"
		return 2
	fi

	local scripts_dir=$1
    local failures=() # List of script|code|output

	echo "====== Execute in '${scripts_dir}' ======"

	for script in "${scripts_dir}"/*; do
		echo "${script}"

		if [[ ! -x "${script}" ]]; then
			echo "Skipping: Not executable"
			continue
		fi

		if [[ ! -f "${script}" ]]; then
			echo "Skipping: Not a regular file"
			continue
		fi

        local output_and_result=$(bash "${script}" 2>&1; echo $?;) # Capture output + exit code
        local output="${output_and_result%$'\n'*}" # Extract everything but the last line
        local exit_code="${output_and_result##*$'\n'}" # Extract last line

        if [[ exit_code -eq 0 ]]; then
            echo "✅ Success"
        else
            echo "❌ Fail"
            failures+=("${script}|${exit_code}|${output}")
        fi
    done

    echo "====== Execution Summary ======"

    if [[ ${#failures[@]} -ne 0 ]]; then
        echo "❌ Failures:"
        for failure in "${failures[@]}"; do
            IFS='|' read -r -d '' script exit_code output <<< "${failure}"
            echo "${script}:"
            echo "exit_code: ${exit_code}"
            echo "----- Output -----"
            echo "${output}"
            echo "------------------"
        done
        echo "====== Done ======"
        exit 1
    fi

    echo "✅ All succeeded!"
    echo "====== Done ======"
}
