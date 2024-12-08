#!/bin/sh

set -ex

setup_brew_pre_installed() {
	command -v brew && return 0

	BREW_PREFIX=/home/linuxbrew/.linuxbrew

	if [ ! -d $BREW_PREFIX/Homebrew ]; then
		return 0
	fi

	export HOMEBREW_NO_ENV_HINTS=1
	export PATH="$BREW_PREFIX/Homebrew/bin:$BREW_PREFIX/bin:$BREW_PREFIX/sbin:$PATH"
	eval "$(brew shellenv)"
}

setup_brew_rootless() {
	command -v brew && return 0

	dpkg-query -W -f='${status}\n' build-essential || exit $?
	command -v curl || exit $?
	command -v git || exit $?
	command -v ps || exit $?

	BREW_PREFIX=$HOME/.linuxbrew/Homebrew

	if [ ! -d $BREW_PREFIX ]; then
		git clone --depth=1 https://github.com/Homebrew/brew $BREW_PREFIX
	fi

	export HOMEBREW_NO_ENV_HINTS=1
	export PATH="$BREW_PREFIX/Homebrew/bin:$BREW_PREFIX/bin:$BREW_PREFIX/sbin:$PATH"
	eval "$(brew shellenv)"
}

setup_perl() {
	command -v cpanm && return 0

	brew install \
		cpanm

	cpanm IPC::Cmd
}

setup_chezmoi() {
	command -v chezmoi && return 0
	command -v gpg || exit $?

	brew install chezmoi
}

setup_bitwarden() {
	command -v bw || brew install bitwarden-cli
	command -v jq || brew install jq

	if  bw status | jq -e '.status' | grep 'unauthenticated'; then
		if [ -z "$BW_CLIENTID" ] || [ -z "$BW_CLIENTSECRET" ]; then
			bw login
		else
			bw login --apikey
		fi
	fi

	BW_SESSION=$(bw unlock --raw)
}

setup_gpg() {
	command -v bw || exit 1
	command -v gpg || exit 1

	test -z "$BW_SESSION" && return 1

	GPG_TTY=$(tty)
	bw get notes "GPG Private Key - gh.heshusius@gmail.com" --session "$BW_SESSION" | gpg --import
}

run_chezmoi() {
    test -d $HOME/.local/share/chezmoi && return 0

    chezmoi init \
        --apply \
        --branch=set-up-git-config-files \
        https://github.com/GerardHH/dotfiles.git
}

setup_brew_pre_installed
setup_brew_rootless
setup_perl
setup_chezmoi
setup_bitwarden
setup_gpg
run_chezmoi
