#!/bin/sh

echo "Start validation..."

DIR=$(dirname "$(readlink -f "$0")")
. $DIR/source_brew.sh

echo "Test brew"
if ! command -v brew && brew install hello && hello; then
	echo "Failed to detect brew, install or run hello program"
	exit 1
fi

echo "Test gpg"
if ! command -v gpg; then
	echo "Failed to detect gpg"
	exit 1
fi

if ! gpg --list-secret-keys "gh.heshusius@gmail.com" | grep "Gerard Heshusius <gh.heshusius@gmail.com>"; then
	echo "Failed to find secret key"
	exit 1
fi

if test -z $GPG_PASSPHRASE; then
	echo "Empty GPG_PASSPHRASE, please set it securily"
	exit 1
fi

GPG_TTY=$(tty) 
echo "Test message" | gpg --batch --yes --pinentry-mode loopback --encrypt --recipient "gh.heshusius@gmail.com" --output test.gpg
if ! gpg --batch --yes --pinentry-mode loopback --passphrase "$GPG_PASSPHRASE" --decrypt test.gpg; then
	echo "Failed to encrypt -> decrypt simple message using gpg"
	rm test.gpg
	exit 1
fi
rm test.gpg
