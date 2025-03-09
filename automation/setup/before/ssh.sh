#!/bin/bash

#shellcheck source=./automation/util.sh
source "${HOME}/dotfiles/automation/util.sh"

ssh_dir="${HOME_DIR}/.ssh"

if [[ ! -d "${ssh_dir}" ]]; then
	echo "Info: '${ssh_dir}' doesn't exist, creating..."
	mkdir -p "${ssh_dir}"
	chmod 700 "${ssh_dir}"
fi

ssh_config="${ssh_dir}/config"

if [[ ! -f "${ssh_config}" ]]; then
	echo "Info: '${ssh_config}' doesn't exist, creating..."
	touch "${ssh_config}"
	chmod 600 "${ssh_config}"
fi

if ! command -v ssh-add; then
	echo "Error: ssh-add not found"
	exit 1
fi

# Format: key_env_var|key_path|host|user_name
keys=(
	"SSH_GITHUB_PRIVATE|${ssh_dir}/github.private|github.com|git"
)

for key in "${keys[@]}"; do
	IFS='|' read -r key_env_var key_path host user_name <<<"${key}"

	echo "Info: key_env_var: ${key_env_var}, key_path: ${key_path}, host: ${host}, user_name: ${user_name}"

	if [[ ! -f "${key_path}" ]]; then
		echo "Info: '${key_path}' doesn't exist, creating..."

		if [[ -z "${!key_env_var}" ]]; then
			echo "Warning: No '${key_env_var}' set, please set it manually or use setup_secrets.sh"
			echo "Skipping..."
			continue
		fi

		echo "${!key_env_var}" | base64 --decode >"${key_path}"
		chmod 600 "${key_path}"
	fi

	{
		echo ""
		echo "Host ${host}"
		echo "    HostName ${host}"
		echo "    User ${user_name}"
		echo "    IdentityFile ${key_path}"
		echo "    AddKeysToAgent yes"
	} >>"${ssh_config}"
done
