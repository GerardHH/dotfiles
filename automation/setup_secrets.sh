#!/bin/bash

if ! command -v bw; then
	echo "Error: Could not find bitwarden cli (bw), please install it or set PATH correctly"
	exit 1
fi

bw login

bw sync

BW_SESSION=$(bw unlock --raw)

{
	echo "GPG_PASSPHRASE=$(bw get password "GPG" --session "${BW_SESSION}")"
	echo "GPG_KEY_PRIVATE=$(bw get notes "gpg.key.private" --session "${BW_SESSION}" | base64 --wrap=0)"
	echo "GPG_KEY_PUBLIC=$(bw get notes "gpg.key.public" --session "${BW_SESSION}" | base64 --wrap=0)"
	echo "SSH_GITHUB_PRIVATE=$(bw get notes "ssh.github.private" --session "${BW_SESSION}" | base64 --wrap=0)"
} >.env

chmod 600 .env

bw lock
