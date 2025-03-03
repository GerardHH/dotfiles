#!/bin/bash

if [[ -z "${ROOT_DIR}" ]]; then
	echo "Error: ROOT_DIR not set"
	exit 2
fi

if ! command -v find; then
	echo "Error: find command not found"
	exit 1
fi

find "${ROOT_DIR}" -type d -name ".git" | while read -r git_dir; do
	repo_dir=$(dirname "${git_dir}")

	echo "Info: repo_dir: ${repo_dir}"

	pushd "${repo_dir}" || exit

	origin_url=$(git remote get-url origin)

	if [[ ! "${origin_url}" =~ ^git@github.com: ]]; then
		echo "Error: '${repo_dir}' is not set to use ssh, but '${origin_url}'"
		exit 1
	fi
done
