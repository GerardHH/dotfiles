#!/bin/sh

set -ex

DIR=$(dirname "$(readlink -f "$0")")
. $DIR/source_brew.sh

command -v brew && \
	brew install hello && \
	hello

command -v bw
if  bw status | jq -e '.status' | grep 'unauthenticated'; then
	if [[ -z "$BW_CLIENTID" || -z "$BW_CLIENTSECRET" ]]; then
		bw login
	else
		bw login --apikey
	fi
fi
BW_SESSION=$(bw unlock --raw)

command -v gpg
gpg --list-secret-keys "gh.heshusius@gmail.com"

(
	set +x
	PASSPHRASE=$(bw get password "gpg" --session "$BW_SESSION")
	if [[ -z "$PASSPHRASE" ]]; then
		echo "Could not retrieve GPG passphrase from bitwarden"
		exit 1
	fi

	GPG_TTY=$(tty) 
	echo "Test message" | gpg --encrypt --yes --recipient "gh.heshusius@gmail.com" --output test.gpg
	if ! gpg --batch --yes --passphrase "$PASSPHRASE" --decrypt test.gpg; then
		echo "Could not encrypt -> decrypt simple message using gpg"
		rm test.gpg
		exit 1
	fi
	rm test.gpg
)

command -v chezmoi
test -d "$HOME/.local/share/chezmoi"

test -f $HOME/.gitconfig
test -f $HOME/.gitconfig.private
test -f $HOME/.gitconfig.lely
