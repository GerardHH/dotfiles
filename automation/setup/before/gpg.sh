#!/bin/bash

#shellcheck source=./automation/util.sh
source "${HOME}"/dotfiles/automation/util.sh

if ! command -v gpg; then
	echo "Error: gpg command not found"
	exit 1
fi

if [[ -f "${ROOT_DIR}"/.env ]]; then
	source "${ROOT_DIR}"/.env
fi

if [[ -z "${GPG_KEY_PRIVATE}" ]]; then
	echo "Error: No GPG_KEY_PRIVATE set, please set it manually or use setup_secrets.sh"
	exit 2
fi

if [[ -z "${GPG_KEY_PUBLIC}" ]]; then
	echo "Error: No GPG_KEY_PUBLIC set, please set it manually or use setup_secrets.sh"
	exit 2
fi

echo "Import private key"
echo "${GPG_KEY_PRIVATE}" | base64 --decode | gpg --batch --yes --pinentry-mode loopback --import

echo "Import public key"
echo "${GPG_KEY_PUBLIC}" | base64 --decode | gpg --batch --yes --pinentry-mode loopback --import

echo "Get list of gpg ID's"
# Extract the key ID on line that starts with fpr, 10th column
KEY_IDS=$(gpg --list-secret-keys --with-colons | awk -F: '/^fpr/{print $10}')
if [[ -z "${KEY_IDS}" ]]; then
	echo "Error: Could not extract key ID"
	exit 1
fi

echo "Set trust per gpg ID"
echo "${KEY_IDS}" | while IFS= read -r key_id; do
	# Set the trust level
	echo "${key_id}:3:" | gpg --import-ownertrust
done
