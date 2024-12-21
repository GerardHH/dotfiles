#!/bin/bash

if ! command -v gpg; then
	echo "Error: gpg command not found"
	return 1
fi

if [ -z "$REPO_ROOT" ]; then
    echo "Warning: REPO_ROOT not set"
fi

if [ -f "$REPO_ROOT"/.env ]; then
	source "$REPO_ROOT"/.env
fi

if [ -z "$GPG_PRIVATE_KEY" ]; then
	echo "Error: No GPG_PRIVATE_KEY set, please set it manually or use setup_secrets.sh"
	return 1
fi

echo "Import private key"
GPG_TTY=$(tty)
echo "$GPG_PRIVATE_KEY" | base64 --decode | gpg --batch --yes --pinentry-mode loopback --import

echo "Set trust level"
# Extract the key ID on line that starts with fpr, 10th column
KEY_ID=$(gpg --list-secret-keys --with-colons | awk -F: '/^fpr/{print $10}')
if [ -z "$KEY_ID" ]; then
	echo "Error: Could not extract key ID"
	return 1
fi

# Set the trust level
echo "$KEY_ID:6:" | gpg --import-ownertrust
