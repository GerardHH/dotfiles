#!/bin/bash

export ROOT_DIR="${HOME}/dotfiles"
export HOME_DIR="${ROOT_DIR}/home"
export AUTO_DIR="${ROOT_DIR}/automation"
export SECRETS_DIR="/run/secrets"

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
	local warnings=() # List of script|output
	local failures=() # List of script|output

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

		local output=$(bash "${script}" 2>&1)

		if [[ "${output}" == *"Warning:"* ]]; then
			echo "⚠️  Warning"
			warnings+=("${script}|${output}")
		elif [[ "${output}" == *"Error:"* ]]; then
			echo "❌ Fail"
			failures+=("${script}|${output}")
		else
			echo "✅ Success"
		fi
	done

	echo "====== Execution Summary ======"

	if [[ ${#warnings[@]} -ne 0 ]]; then
		echo "⚠️ Warnings:"
		for warning in "${warnings[@]}"; do
			IFS='|' read -r -d '' script output <<<"$warning"
			echo "${script}:"
			echo "----- Output -----"
			echo "${output}"
			echo "------------------"
		done
	fi

	if [[ ${#failures[@]} -ne 0 ]]; then
		echo "❌ Failures:"
		for failure in "${failures[@]}"; do
			IFS='|' read -r -d '' script output <<<"${failure}"
			echo "${script}:"
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

load_secrets() {
	if [[ -f "${AUTO_DIR}"/.env ]]; then
		echo "Info: Load secrets in '${AUTO_DIR}'"
		source "${AUTO_DIR}"/.env
	elif [[ -f "${SECRETS_DIR}/.env" ]]; then
		echo "Info: Load secrets in '${SECRETS_DIR}'"
		source "${SECRETS_DIR}/.env"
	else
		echo "Warning: No secrets loaded"
	fi
}
