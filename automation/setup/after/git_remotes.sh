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

	if ! pushd "${repo_dir}"; then
		echo "Warning: Could not pushd into '${repo_dir}', skipping..."
		continue
	fi

	origin_url=$(git remote get-url origin)

	if [[ -z "${origin_url}" ]]; then
		echo "Info: No 'origin' remote found in '${origin_url}', skipping..."
		popd || exit
		continue
	fi

	if [[ "${origin_url}" =~ ^https://github\.com/ ]]; then
		# Example: https://github.com/USERNAME/REPO.git -> git@github.com:USERNAME/REPO.git
		ssh_url="$(echo "${origin_url}" | sed -E 's|^https://github\.com/([^/]+)/(.+)|git@github.com:\1/\2|')"

		echo "Info: '${origin_url}' -> '${ssh_url}'"

		git remote set-url origin "${ssh_url}"
	fi

	if ! popd; then
		echo "Warning: Could not popd"
	fi
done
