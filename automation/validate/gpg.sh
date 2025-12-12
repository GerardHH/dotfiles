#!/bin/bash

#shellcheck source=./automation/util.sh
source "${HOME}"/dotfiles/automation/util.sh

if ! command -v gpg; then
	log_error "Failed to detect gpg"
	exit 1
fi

if [[ -z "$(gpg --list-secret-keys)" ]]; then
	log_error "gpg doesn't have any private keys"
	exit 1
fi

load_secrets

if [[ -z "${GPG_PASSPHRASE}" ]]; then
	log_error "Empty GPG_PASSPHRASE, please set it securily"
	exit 1
fi

log_info "Encrypt message"
echo "Test message" | gpg --batch --yes --pinentry-mode loopback --encrypt --recipient "gh.heshusius@gmail.com" --output test.gpg

# shellcheck disable=SC2181
if [[ "$?" -ne 0 ]]; then
	log_error "Encryption failed"
	exit 1
fi

log_info "Decrypt message"
if ! gpg --batch --yes --pinentry-mode loopback --passphrase "${GPG_PASSPHRASE}" --decrypt test.gpg; then
	log_error "Failed to encrypt -> decrypt simple message using gpg"
	rm test.gpg
	exit 1
fi
rm test.gpg
