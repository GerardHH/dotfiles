#!/bin/bash

if ! command -v gpg; then
	echo "Error: gpg command not found"
	exit 1
fi

if [[ -z "$(gpg --list-secret-keys)" ]]; then
	echo "Error: gpg doesn't have any private keys"
	exit 1
fi

if [[ -z "${ROOT_DIR}" ]]; then
	echo "Error: ROOT_DIR not set"
	exit 1
fi

load_secrets

if [[ -z "${GPG_PASSPHRASE}" ]]; then
	echo "Error: Empty GPG_PASSPHRASE, please set it securily"
	exit 1
fi

SOURCE_DIR="${ROOT_DIR}/home"

echo "Source dir: ${SOURCE_DIR}"

find "${SOURCE_DIR}" -type f -name "*.gpg" | while read -r file; do
	rel_path="${file#"${SOURCE_DIR}"/}"
	dest_path="${SOURCE_DIR}/${rel_path}"
	dest_path="${dest_path%.gpg}"

	echo "Decrypt: '${file}' into '${dest_path}'"

	if [[ -f "${dest_path}" ]]; then
		echo "Warning: Already exists, skipping"
		continue
	fi

	if gpg --batch --yes --pinentry-mode loopback --passphrase "${GPG_PASSPHRASE}" --output "${dest_path}" --decrypt "${file}"; then
		echo "Success!"
	else
		echo "Warning: Failed to decrypt"
	fi
done
