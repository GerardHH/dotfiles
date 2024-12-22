#!/bin/bash

if ! command -v gpg; then
	echo "Error: Failed to detect gpg"
	exit 1
fi

if [[ ! -n $(gpg --list-secret-keys ) ]]; then
    echo "Error: gpg doesn't have any private keys"
    exit 1
fi

if [ -f "$UTIL_DIR"/.env ]; then
	source "$UTIL_DIR"/.env
fi

if test -z "$GPG_PASSPHRASE"; then
	echo "Error: Empty GPG_PASSPHRASE, please set it securily"
	exit 1
fi

GPG_TTY=$(tty)
echo "Test message" | gpg --batch --yes --pinentry-mode loopback --encrypt --recipient "gh.heshusius@gmail.com" --output test.gpg
if ! gpg --batch --yes --pinentry-mode loopback --passphrase "$GPG_PASSPHRASE" --decrypt test.gpg; then
	echo "Error: Failed to encrypt -> decrypt simple message using gpg"
	rm test.gpg
	exit 1
fi
rm test.gpg
