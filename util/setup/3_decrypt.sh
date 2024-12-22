#!/bin/bash

if ! command -v gpg; then
    echo "Error: gpg command not found"
    return 1
fi

if [[ ! -n $(gpg --list-secret-keys ) ]]; then
    echo "Error: gpg doesn't have any private keys"
    return 1
fi

if [ -z "$GPG_PASSPHRASE" ]; then
	echo "Error: Empty GPG_PASSPHRASE, please set it securily"
	return 1
fi

if [ -z "$REPO_ROOT" ]; then
    echo "Error: REPO_ROOT not set"
    return 1
fi

SOURCE_DIR="$REPO_ROOT"/encrypted
TARGET_DIR="$REPO_ROOT"/home

echo "Source dir: $SOURCE_DIR"
echo "Target dir: $TARGET_DIR"

find "$SOURCE_DIR" -type f -name "*.gpg" | while read -r file; do
    rel_path="${file#$SOURCE_DIR/}"
    dest_path="$TARGET_DIR/$rel_path"
    dest_path="${dest_path%.gpg}"

    echo "Decrypt: '$file' into '$dest_path'"

    if [ -f "$dest_path" ]; then
        echo "Warning: Already exists, skipping"
        continue
    fi

    dest_dir=$(dirname "$dest_path")
    if [ ! -d $dest_dir ]; then
        echo "Warning: Parent directory doesn't exist, creating"
        mkdir -p "$dest_dir"
    fi

    if gpg --batch --yes --pinentry-mode loopback --passphrase "$GPG_PASSPHRASE" --output "$dest_path" --decrypt "$file"; then
        echo "Success!"
    else
        echo "Warning: Failed to decrypt"
    fi
done
