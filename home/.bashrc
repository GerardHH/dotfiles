#!/bin/bash

# Sources
source "$HOME"/dotfiles/automation/source_brew.sh
CARGO="$HOME/.cargo/env"
if [ -e "$CARGO" ]; then
	source "$CARGO"
fi

# INFO If not running interactively, then only source and skip the rest
[[ $- != *i* ]] && return

source /etc/profile.d/bash_completion.sh

source "$HOME/.config/bash/eza.sh"
source "$HOME/.config/bash/fzf/fzf.sh"
source "$HOME/.config/bash/history_config.sh"

# Aliases
alias ld='lazydocker'
alias lg='lazygit'
alias top='btop'
alias vi='nvim'

# Exports
export EDITOR="nvim"
export RIPGREP_CONFIG_PATH="$HOME/.ripgreprc"
export NAVI_PATH="$HOME/.config/navi/cheats"

# Start up executions
oh-my-posh disable notice

# Shell integrations
eval "$(navi widget bash)"
eval "$(zoxide init --cmd cd bash)"
eval "$(oh-my-posh init bash --config ~/.config/oh-my-posh/theme.toml)"
