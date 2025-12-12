#!/bin/sh

BRANCH=main
SOURCE=https://github.com/GerardHH/dotfiles.git
TARGET="${HOME}"/dotfiles

git clone --branch "${BRANCH}" "${SOURCE}" "${TARGET}"

"${TARGET}"/automation/setup.sh
