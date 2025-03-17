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

	pushd "${repo_dir}" || exit

	origin_url=$(git remote get-url origin)

	if [[ ! "${origin_url}" =~ ^git@github.com: ]]; then
		log_error "'${repo_dir}' is not set to use ssh, but '${origin_url}'"
		exit 1
	fi
done
