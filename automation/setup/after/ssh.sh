#!/bin/bash

ssh_dir="${HOME}/.ssh"

if [[ ! -d "${ssh_dir}" ]]; then
	echo "Error: '${ssh_dir}' not found"
	exit 1
fi

github_message="Hi GerardHH! You've successfully authenticated, but GitHub does not provide shell access."
# Format: key_path|host|user_name|welcome_message
keys=(
	"${ssh_dir}/github.private|github.com|git|${github_message}"
)

for key in "${keys[@]}"; do
	IFS='|' read -r key_path host user_name welcome_message <<<"${key}"

	eval "$(ssh-agent -s)"

	if ! ssh-add "${key_path}"; then
		echo "Error: Failed to add SSH key '${key_path}'"
		exit 1
	fi

	if ! ssh -T -o StrictHostKeyChecking=no "${user_name}@${host}" | grep --quiet "${welcome_message}"; then
		echo "Error: Connection '${user_name}@${host}' did not welcome with '${welcome_message}'"
		exit 1
	fi
done
