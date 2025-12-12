#!/bin/bash

if ! command -v curl; then
	log_error "Could not find curl"
	exit 1
fi

if ! command -v fc-cache; then
	log_error "Could not find fc-cache"
	exit 1
fi

if ! command -v tar; then
	log_error "Could not find tar"
	exit 1
fi

FONT_FAM="Hack"
FONT_DIR="${HOME}/.local/share/fonts/${FONT_FAM}"

if [[ ! -d "${FONT_DIR}" ]]; then
	log_warning "'${FONT_DIR}' not found, creating..."
	mkdir -p "${FONT_DIR}"
fi

FONT_TAR="${FONT_FAM}.tar.xz"

log_info "Download fonts"
if ! curl --location https://github.com/ryanoasis/nerd-fonts/releases/latest/download/"${FONT_TAR}" --output "${FONT_TAR}" --output-dir "${FONT_DIR}"; then
	log_error "Could not download '${FONT_FAM}'"
	exit 1
fi

log_info "Extract font tar"
pushd "${FONT_DIR}" || exit
if ! tar --extract --file="${FONT_TAR}"; then
	log_error "Could not extract '${FONT_FAM}' in '${FONT_DIR}'"
	popd || exit
	exit 1
fi
popd || exit

log_info "Refresh font cache"
fc-cache -fv

log_info "Clean up tar"
if ! rm "${FONT_DIR}/${FONT_TAR}"; then
	log_warning "Could not remove '${FONT_TAR}' in '${FONT_DIR}'"
fi
