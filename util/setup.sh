#!/bin/sh

set -ex

setup_brew() {
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
	export PATH="$BREW_PREFIX/bin:$BREW_PREFIX/sbin:$PATH"
	eval "$($BREW_PREFIX/bin/brew shellenv)"
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

run_chezmoi() {
    test -d $HOME/.local/share/chezmoi && return 0

    chezmoi init \
        --apply \
        --branch=set-up-git-config-files \
        https://github.com/GerardHH/dotfiles.git
}

setup_brew
setup_perl
setup_chezmoi
run_chezmoi
