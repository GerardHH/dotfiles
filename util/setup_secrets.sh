#!/bin/bash

if ! command -v bw; then
	echo "Error: Could not find bitwarden cli (bw), please install it or set PATH correctly"
	exit 1
fi

bw login

BW_SESSION=$(bw unlock --raw)

echo "\
GPG_PASSPHRASE=$(bw get password "GPG" --session "${BW_SESSION}")
GPG_PRIVATE_KEY=$(bw get notes "GPG Private Key" --session "${BW_SESSION}" | base64 --wrap=0)
" > .env

chmod 600 .env

bw lock
