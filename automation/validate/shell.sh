#!/bin/bash

#shellcheck source=./automation/util.sh
source "${HOME}/dotfiles/automation/util.sh"

DEPS=(
	"eza"
	"fzf"
	"navi"
	"oh-my-posh"
	"tmux"
	"zoxide"
)

MISSING=()

for dep in "${DEPS[@]}"; do
	if ! command -v "$dep"; then
		MISSING+=("${dep}")
	fi
done

if [ "${#MISSING[@]}" -gt 0 ]; then
	log_error "The following dependencies are missing:"
	printf '%s\n' "${MISSING[@]}"
	exit 1
fi

if ! command -v bash; then
	log_error "Could not find bash"
	exit 1
fi

if [[ ! -L "${HOME}/.bashrc" ]]; then
	log_error ".bashrc not deployed"
	exit 1
fi

if [[ ! -d "${HOME}/.config/bash/fzf/fzf-tab-completion" ]]; then
	log_error "fzf-tab-completion not installed"
	exit 1
fi

OUTPUT=$(bash-c "source ${HOME}/.bashrc")
if [[ -n "${OUTPUT}" ]]; then
	log_error "sourcing .bashrc gave output:"
	log_error "${OUTPUT}"
	exit 1
fi
