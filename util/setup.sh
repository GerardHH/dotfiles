#!/bin/sh

set -ex

install_brew() {
	command -v brew && return

	dpkg-query -W -f='${status}' build-essential || exit $?
	echo "" # Above command doesn't print a new line
	command -v curl || exit $?
	command -v git || exit $?
	command -v ps || exit $?

	BREW_PREFIX=$HOME/.linuxbrew/Homebrew

	if [ ! -d $BREW_PREFIX ]; then
		git clone --depth=1 https://github.com/Homebrew/brew $BREW_PREFIX
	fi
}

install_brew
