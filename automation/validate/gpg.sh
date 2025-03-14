#!/bin/bash

#shellcheck source=./automation/util.sh
source "${HOME}"/dotfiles/automation/util.sh

if ! command -v gpg; then
	echo "Error: Failed to detect gpg"
	exit 1
fi

if [[ -z "$(gpg --list-secret-keys)" ]]; then
	echo "Error: gpg doesn't have any private keys"
	exit 1
fi

load_secrets

if [[ -z "${GPG_PASSPHRASE}" ]]; then
	echo "Error: Empty GPG_PASSPHRASE, please set it securily"
	exit 1
fi

echo "Info: Encrypt message"
echo "Test message" | gpg --batch --yes --pinentry-mode loopback --encrypt --recipient "gh.heshusius@gmail.com" --output test.gpg

# shellcheck disable=SC2181
if [[ "$?" -ne 0 ]]; then
	echo "Error: Encryption failed"
	exit 1
fi

echo "Info: Decrypt message"
if ! gpg --batch --yes --pinentry-mode loopback --passphrase "${GPG_PASSPHRASE}" --decrypt test.gpg; then
	echo "Error: Failed to encrypt -> decrypt simple message using gpg"
	rm test.gpg
	exit 1
fi
rm test.gpg
