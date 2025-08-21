#!/bin/bash

export ROOT_DIR="${HOME}/dotfiles"
export HOME_DIR="${ROOT_DIR}/home"
export AUTO_DIR="${ROOT_DIR}/automation"
export SECRETS_DIR="/run/secrets"

source "${AUTO_DIR}/source_brew.sh"

ERROR="ERROR"
INFO="INFO"
WARNING="WARNING"

brew_install() {
	if [[ "$#" -eq 0 ]]; then
		log_error "Nothing to install"
		log_info "Usage: brew_install neovim fzf zoxide"
		return 2
	fi

	if ! command -v brew; then
		log_error "Could not find brew, please set it up or source it"
		return 2
	fi

	brew install "$@"
}

execute_scripts() {
	if [[ "$#" -eq 0 ]]; then
		log_error "No folder provided"
		log_info "Usage: execute_scripts <folder>"
		return 2
	fi

	local scripts_dir=$1
	local warnings=() # List of script|output
	local failures=() # List of script|output

	log_info "====== Execute in '${scripts_dir}' ======"

	for script in "${scripts_dir}"/*; do
		log_info "${script}"

		if [[ ! -x "${script}" ]]; then
			log_info "Skipping: Not executable"
			continue
		fi

		if [[ ! -f "${script}" ]]; then
			log_info "Skipping: Not a regular file"
			continue
		fi

		local output=$(bash "${script}" 2>&1)

		if [[ "${output}" == *"${WARNING}:"* ]]; then
			log_info "⚠️  Warning"
			warnings+=("${script}|${output}")
		elif [[ "${output}" == *"${ERROR}:"* ]]; then
			log_info "❌ Fail"
			failures+=("${script}|${output}")
		else
			log_info "✅ Success"
		fi
	done

	log_info "====== Execution Summary ======"

	if [[ ${#warnings[@]} -ne 0 ]]; then
		log_info "⚠️ Warnings:"
		for warning in "${warnings[@]}"; do
			IFS='|' read -r -d '' script output <<<"$warning"
			log_info "${script}:"
			log_info "----- Output -----"
			log_info "${output}"
			log_info "------------------"
		done
	fi

	if [[ ${#failures[@]} -ne 0 ]]; then
		log_info "❌ Failures:"
		for failure in "${failures[@]}"; do
			IFS='|' read -r -d '' script output <<<"${failure}"
			log_info "${script}:"
			log_info "----- Output -----"
			log_info "${output}"
			log_info "------------------"
		done
		log_info "====== Done ======"
		exit 1
	fi

	log_info "✅ All succeeded!"
	log_info "====== Done ======"
}

load_secrets() {
	set -a
	if [[ -f "${ROOT_DIR}"/.env ]]; then
		log_info "Load secrets in '${ROOT_DIR}'"
		source "${ROOT_DIR}"/.env
	elif [[ -f "${AUTO_DIR}"/.env ]]; then
		log_info "Load secrets in '${AUTO_DIR}'"
		source "${AUTO_DIR}"/.env
	elif [[ -f "${SECRETS_DIR}/.env" ]]; then
		log_info "Load secrets in '${SECRETS_DIR}'"
		source "${SECRETS_DIR}/.env"
	else
		log_warning "No secrets loaded, searched in [ ${ROOT_DIR}, ${AUTO_DIR}, ${SECRETS_DIR} ]"
	fi
	set +a
}

log() {
	if [[ "$#" -ne 2 ]]; then
		echo "${ERROR}: No log level and/or text provided"
		echo "${INFO}: Usage: log <log_level> <text>"
		exit 1
	fi
	echo "$1: $2"
}

log_error() {
	log "${ERROR}" "$1"
}

log_info() {
	log "${INFO}" "$1"
}

log_warning() {
	log "${WARNING}" "$1"
}
