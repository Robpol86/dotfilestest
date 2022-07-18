#!/bin/zsh

# Functions and aliases for zsh.

source ~/.commonrc

# zsh
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="robpol86"
CASE_SENSITIVE="true"
DISABLE_UNTRACKED_FILES_DIRTY="true"
HIST_STAMPS="yyyy-mm-dd"
plugins=(docker git macports virtualenv zsh-syntax-highlighting)
source "$ZSH/oh-my-zsh.sh"

# Numpad https://superuser.com/questions/742171/zsh-z-shell-numpad-numlock-doesnt-work/742193
bindkey -s "^[Oj" "*"
bindkey -s "^[Ok" "+"
bindkey -s "^[Ol" "."
bindkey -s "^[Om" "-"
bindkey -s "^[OM" "^M"
bindkey -s "^[Oo" "/"
bindkey -s "^[Op" "0"
bindkey -s "^[Oq" "1"
bindkey -s "^[Or" "2"
bindkey -s "^[Os" "3"
bindkey -s "^[Ot" "4"
bindkey -s "^[Ou" "5"
bindkey -s "^[Ov" "6"
bindkey -s "^[Ow" "7"
bindkey -s "^[Ox" "8"
bindkey -s "^[Oy" "9"
# Bash-like
bindkey "^U" backward-kill-line
backward-kill-word-bash () {
    # By sitaktif: https://unix.stackexchange.com/a/586378/206171
    local WORDCHARS='*?_-.[]~=/&;!#$%^(){}<>:,"'"'"
    zle -f kill # Append to the kill ring on subsequent kills.
    zle backward-kill-word
}
bindkey "^W" backward-kill-word-bash && zle -N "$_"

# History.
HISTSIZE=50000  # Number of lines kept in memory.
SAVEHIST=999999  # Number of lines stored on disk.
setopt extended_history  # Timestamps in history file.
setopt hist_ignore_all_dups
unsetopt share_history
