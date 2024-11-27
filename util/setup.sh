#!/bin/sh

set -ex

setup_brew() {
	command -v brew && return

	dpkg-query -W -f='${status}\n' build-essential || exit $?
	command -v curl || exit $?
	command -v git || exit $?
	command -v ps || exit $?

	BREW_PREFIX=$HOME/.linuxbrew/Homebrew

	if [ ! -d $BREW_PREFIX ]; then
		git clone --depth=1 https://github.com/Homebrew/brew $BREW_PREFIX
	fi

    DIR=$(dirname "$(readlink -f "$0")")
    . $DIR/source_brew.sh
}

setup_chezmoi() {
	brew install chezmoi
}

clone_repo() {
    chezmoi init \
        --branch=set-up-git-config-files \
        https://github.com/GerardHH/dotfiles.git
}

setup_brew
setup_chezmoi
clone_repo
