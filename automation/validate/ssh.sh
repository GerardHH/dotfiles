#!/bin/bash

if [[ -z "${HOME_DIR}" ]]; then
	echo "Error: HOME_DIR not set"
	exit 2
fi

ssh_source_dir="${HOME}/dotfiles/home/.ssh"

if [[ ! -d "${ssh_source_dir}" ]]; then
	echo "Error: '${ssh_source_dir}' doesn't exist"
	exit 1
fi

if [[ ! $(stat -c '%a' "${ssh_source_dir}") -eq 700 ]]; then
	echo "Error: '${ssh_source_dir}' doesn't have 700 permissions"
	exit 1
fi

ssh_target_dir="${HOME}/.ssh"

if [[ ! -d "${ssh_target_dir}" ]]; then
	echo "Error: '${ssh_target_dir}' doesn't exist"
	exit 1
fi

if [[ ! $(stat -c '%a' "${ssh_target_dir}") -eq 700 ]]; then
	echo "Error: '${ssh_target_dir}' doesn't have 700 permissions"
	exit 1
fi

ssh_source_config="${ssh_source_dir}/config"

if [[ ! -f "${ssh_source_config}" ]]; then
	echo "Error: '${ssh_source_config}' doesn't exist"
	exit 1
fi

if [[ ! $(stat -c '%a' "${ssh_source_config}") -eq 600 ]]; then
	echo "Error: '${ssh_source_config}' doesn't have 600 permissions"
	exit 1
fi

ssh_target_config="${ssh_target_dir}/config"

if [[ ! -L "${ssh_target_config}" ]]; then
	echo "Error: '${ssh_target_config}' is not linked"
	exit 1
fi

github_message="Hi GerardHH! You've successfully authenticated, but GitHub does not provide shell access."
# Format: key_env_var|key_path|host|user_name|welcome_message
keys=(
	"SSH_GITHUB_PRIVATE|github.private|github.com|git|${github_message}"
)

for key in "${keys[@]}"; do
	IFS='|' read -r key_env_var key_path host user_name welcome_message <<<"${key}"

	echo "Info: key_env_var: ${key_env_var}, key_path: ${key_path}, host: ${host}, user_name: ${user_name}, welcome_message: ${welcome_message}"

	if [[ ! -f "${ssh_source_dir}/${key_path}" ]]; then
		echo "Error: '${ssh_source_dir}/${key_path}' doesn't exist"
		exit 1
	fi

	if [[ ! $(stat -c '%a' "${ssh_source_dir}/${key_path}") -eq 600 ]]; then
		echo "Error: '${ssh_source_dir}/${key_path}' doesn't have 600 permissions"
		exit 1
	fi

	if [[ ! -L "${ssh_target_dir}/${key_path}" ]]; then
		echo "Error: '${ssh_target_dir}/${key_path}' is not linked"
		exit 1
	fi

	if ! grep --perl-regexp --null-data --only-matching \
		"Host ${host}\n\s+HostName ${host}\n\s+User ${user_name}\n\s+IdentityFile ${ssh_source_dir}/${key_path}" \
		"${ssh_source_config}"; then
		echo "Error: '${key}' not found in '${ssh_source_config}'"
		exit 1
	fi

	if ! ssh -T -o StrictHostKeyChecking=no "${user_name}@${host}" | grep --quiet "${welcome_message}"; then
		echo "Error: Connection '${user_name}@${host}' did not return '${welcome_message}'"
		exit 1
	fi
done
