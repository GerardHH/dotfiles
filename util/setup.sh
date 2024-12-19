#!/bin/sh

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
}

setup_perl() {
	command -v cpanm && return 0

	brew install \
		cpanm

	cpanm IPC::Cmd
}

setup_gpg() {
	command -v gpg || exit 1

	if test -z "$GPG_PRIVATE_KEY"; then
		echo "No GPG_PRIVATE_KEY set, please set it manually or use setup_secrets.sh"
	fi

	GPG_TTY=$(tty)
	echo "$GPG_PRIVATE_KEY" | gpg --batch --yes --pinentry-mode loopback --import 
}

setup_brew_rootless
. $HOME/dotfiles/util/source_brew.sh

setup_perl
setup_gpg
