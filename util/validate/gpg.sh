#!/bin/bash

if ! command -v gpg; then
	echo "Error: Failed to detect gpg"
	return 1
fi

if ! gpg --list-secret-keys "gh.heshusius@gmail.com" | grep "Gerard Heshusius <gh.heshusius@gmail.com>"; then
	echo "Error: Failed to find secret key"
	return 1
fi

if test -z $GPG_PASSPHRASE; then
	echo "Error: Empty GPG_PASSPHRASE, please set it securily"
	return 1
fi

GPG_TTY=$(tty)
echo "Test message" | gpg --batch --yes --pinentry-mode loopback --encrypt --recipient "gh.heshusius@gmail.com" --output test.gpg
if ! gpg --batch --yes --pinentry-mode loopback --passphrase "$GPG_PASSPHRASE" --decrypt test.gpg; then
	echo "Error: Failed to encrypt -> decrypt simple message using gpg"
	rm test.gpg
	return 1
fi
rm test.gpg
