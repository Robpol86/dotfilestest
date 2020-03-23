#!/bin/zsh

# https://github.com/Robpol86/dotfiles

# zsh
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="robpol86"
CASE_SENSITIVE="true"
DISABLE_UNTRACKED_FILES_DIRTY="true"
HIST_STAMPS="yyyy-mm-dd"
plugins=(docker git kubectl macports virtualenv zsh-syntax-highlighting)
source "$ZSH/oh-my-zsh.sh"

# Aliases
alias lower="tr '[:upper:]' '[:lower:]'"
alias upper="tr '[:lower:]' '[:upper:]'"

# History.
HISTSIZE=50000  # Number of lines kept in memory.
SAVEHIST=999999  # Number of lines stored on disk.
setopt extended_history  # Timestamps in history file.
setopt hist_ignore_all_dups
setopt share_history  # All terminals share the same history.
