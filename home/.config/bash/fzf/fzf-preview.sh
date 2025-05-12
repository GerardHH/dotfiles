#!/bin/bash

__fzf_preview() {
	target=$1

	if [[ -d "$target" ]]; then
		eza --icons --color=always --all --tree --level=1 "$target"
	elif [[ -f "$target" ]]; then
		bat --style=numbers --color=always "$target" 2>/dev/null || head -n 40 "$target"
	elif command -v "$target" &>/dev/null; then
		"$target" --help || man "$target"
	fi
}
