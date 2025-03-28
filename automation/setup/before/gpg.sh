#!/bin/bash

#shellcheck source=./automation/util.sh
source "${HOME}"/dotfiles/automation/util.sh

if ! command -v gpg; then
	log_error "gpg command not found"
	exit 1
fi

# Returns 0 when found
if gpg --list-secret-key --with-colons | grep "Gerard Heshusius <gh.heshusius@gmail.com>"; then
	log_info "Secret key already known, stopping"
	exit 0
fi

brew_install expect

load_secrets

if [[ -z "${GPG_KEY_PRIVATE}" ]]; then
	log_error "No GPG_KEY_PRIVATE set, please set it manually or use setup_secrets.sh"
	exit 2
fi

if [[ -z "${GPG_KEY_PUBLIC}" ]]; then
	log_error "No GPG_KEY_PUBLIC set, please set it manually or use setup_secrets.sh"
	exit 2
fi

log_info "Import private key"
echo "${GPG_KEY_PRIVATE}" | base64 --decode | gpg --batch --yes --pinentry-mode loopback --import

log_info "Import public key"
echo "${GPG_KEY_PUBLIC}" | base64 --decode | gpg --batch --yes --pinentry-mode loopback --import

KEY_ID=$(gpg --list-secret-key --with-colons | awk -F: '/^fpr/{print $10}' | head -n 1)

expect <<EOF
spawn gpg --edit-key ${KEY_ID}
expect "gpg>"
send "trust\n"
expect "Your decision?"
send "5\n"
expect "Do you really want to set this key to ultimate trust? (y/N)"
send "y\n"
expect "gpg>"
send "save\n"
EOF
# Make sure there's a new line at end of this scripts output
# util.sh::execute_scripts expects that
echo ""
