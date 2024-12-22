#!/bin/bash

if ! command -v gpg; then
	echo "Error: gpg command not found"
	exit 1
fi

if [ -z "$ROOT_DIR" ]; then
    echo "Warning: ROOT_DIR not set"
fi

if [ -f "$ROOT_DIR"/.env ]; then
	source "$ROOT_DIR"/.env
fi

if [ -z "$GPG_PRIVATE_KEY" ]; then
	echo "Error: No GPG_PRIVATE_KEY set, please set it manually or use setup_secrets.sh"
	exit 1
fi

echo "Import private key"
GPG_TTY=$(tty)
echo "$GPG_PRIVATE_KEY" | base64 --decode | gpg --batch --yes --pinentry-mode loopback --import

echo "Set trust level"
# Extract the key ID on line that starts with fpr, 10th column
KEY_ID=$(gpg --list-secret-keys --with-colons | awk -F: '/^fpr/{print $10}')
if [ -z "$KEY_ID" ]; then
	echo "Error: Could not extract key ID"
	exit 1
fi

# Set the trust level
echo "$KEY_ID:6:" | gpg --import-ownertrust
