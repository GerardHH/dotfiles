#!/usr/bin/env bash

if [[ "$#" -ne 2 ]]; then
	echo "Remove all symlinks found in BASE_DIR that contain the TARGET_SUBSTRING in their link"
	echo "Usage: $0 BASE_DIR TARGET_SUBSTRING"
	echo "Example: $0 /home/user /dotfiles"
	exit 1
fi

BASE_DIR="@1"
TARGET_SUBSTRING="@2"

find "${BASE_DIR}" -type l | while read -r LINK_PATH; do
	# Retrieve the string stored in in the symlink
	SYMLINK_TARGET=$(readlink "${LINK_PATH}")

	if [[ "${SYMLINK_TARGET}" == *"${TARGET_SUBSTRING}"* ]]; then
		echo "Removing symlink ${LINK_PATH} -> ${SYMLINK_TARGET}"
		rm "${LINK_PATH}"
	else
		echo "Skipping ${LINK_PATH} (points to ${SYMLINK_TARGET})"
	fi
done
