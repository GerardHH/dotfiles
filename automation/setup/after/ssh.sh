#!/bin/bash

ssh_dir="${HOME}/.ssh"

if [[ ! -d "${ssh_dir}" ]]; then
	log_error "'${ssh_dir}' not found"
	exit 1
fi

# Format: key_path|host|user_name
keys=(
	"${ssh_dir}/github.private|github.com|git"
)

for key in "${keys[@]}"; do
	IFS='|' read -r key_path host user_name <<<"${key}"

	eval "$(ssh-agent -s)"

	if ! ssh-add "${key_path}"; then
		log_error "Failed to add SSH key '${key_path}'"
		exit 1
	fi

	local exit_code=$(ssh -T -o StrictHostKeyChecking=no "${user_name}@${host}")
	if [[ "${exit_code}" -eq 255 ]]; then
		log_error "Connection '${user_name}@${host}' refused"
		exit 1
	fi
done
