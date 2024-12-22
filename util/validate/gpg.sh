#!/bin/bash

source "${HOME}"/dotfiles/util/util.sh

if ! command -v gpg; then
	echo "Error: Failed to detect gpg"
	exit 1
fi

if [[ -z "$(gpg --list-secret-keys)" ]]; then
    echo "Error: gpg doesn't have any private keys"
    exit 1
fi

if [[ -z "${UTIL_DIR}" ]]; then
    echo "Error: UTIL_DIR not set"
    exit 1
fi

if [[ -f "${UTIL_DIR}"/.env ]]; then
	source "${UTIL_DIR}"/.env
fi

if [[ -z "${GPG_PASSPHRASE}" ]]; then
	echo "Error: Empty GPG_PASSPHRASE, please set it securily"
	exit 1
fi

echo "Test message" | gpg --batch --yes --pinentry-mode loopback --encrypt --recipient "gh.heshusius@gmail.com" --output test.gpg
if ! gpg --batch --yes --pinentry-mode loopback --passphrase "${GPG_PASSPHRASE}" --decrypt test.gpg; then
	echo "Error: Failed to encrypt -> decrypt simple message using gpg"
	rm test.gpg
	exit 1
fi
rm test.gpg
