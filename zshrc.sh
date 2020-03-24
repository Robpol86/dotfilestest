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

# Numpad https://superuser.com/questions/742171/zsh-z-shell-numpad-numlock-doesnt-work/742193
bindkey -s "^[Oo" "/"; bindkey -s "^[Oj" "*"; bindkey -s "^[Om" "-"
bindkey -s "^[Ow" "7"; bindkey -s "^[Ox" "8"; bindkey -s "^[Oy" "9"; bindkey -s "^[Ok" "+"
bindkey -s "^[Ot" "4"; bindkey -s "^[Ou" "5"; bindkey -s "^[Ov" "6"
bindkey -s "^[Oq" "1"; bindkey -s "^[Or" "2"; bindkey -s "^[Os" "3"; bindkey -s "^[OM" "^M"
bindkey -s "^[Op" "0"; bindkey -s "^[Ol" "."

# Aliases
alias lower="tr '[:upper:]' '[:lower:]'"
alias upper="tr '[:lower:]' '[:upper:]'"

# History.
HISTSIZE=50000  # Number of lines kept in memory.
SAVEHIST=999999  # Number of lines stored on disk.
setopt extended_history  # Timestamps in history file.
setopt hist_ignore_all_dups
setopt share_history  # All terminals share the same history.
