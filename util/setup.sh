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

    export PATH="$HOME/.linuxbrew/Homebrew/bin:$HOME/.linuxbrew/Homebrew/sbin:$PATH"
    eval "$($HOME/.linuxbrew/Homebrew/bin/brew shellenv)"
}

setup_chezmoi() {
    command -v chezmoi && return 0

	brew install chezmoi
}

clone_repo() {
    test -d $HOME/.local/share/chezmoi && return 0

    chezmoi init \
        --branch=set-up-git-config-files \
        https://github.com/GerardHH/dotfiles.git
}

setup_brew
setup_chezmoi
clone_repo
