#!/bin/bash

if [[ -z "${ROOT_DIR}" ]]; then
	log_error "ROOT_DIR not set"
	exit 2
fi

if ! command -v find; then
	log_error "find command not found"
	exit 1
fi

find "${ROOT_DIR}" -type d -name ".git" | while read -r git_dir; do
	repo_dir=$(dirname "${git_dir}")

	log_info "repo_dir: ${repo_dir}"

	if ! pushd "${repo_dir}"; then
		log_warning "Could not pushd into '${repo_dir}', skipping..."
		continue
	fi

	origin_url=$(git remote get-url origin)

	if [[ -z "${origin_url}" ]]; then
		log_info "No 'origin' remote found in '${origin_url}', skipping..."
		popd || exit
		continue
	fi

	if [[ "${origin_url}" =~ ^https://github\.com/ ]]; then
		# Example: https://github.com/USERNAME/REPO.git -> git@github.com:USERNAME/REPO.git
		ssh_url="$(echo "${origin_url}" | sed -E 's|^https://github\.com/([^/]+)/(.+)|git@github.com:\1/\2|')"

		log_info "'${origin_url}' -> '${ssh_url}'"

		git remote set-url origin "${ssh_url}"
	fi

	if ! popd; then
		log_warning "Could not popd"
	fi
done
