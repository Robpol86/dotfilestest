#!/bin/bash

# Functions and aliases for bash.

# shellcheck source=./commonrc.sh
source ~/.commonrc

# Aliases.
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'
alias grep='grep --color=auto'
if [[ $OSTYPE == darwin* ]]; then
    # Aliases for macOS only.
    alias ls='ls -G'
else
    alias ls='ls --color=auto'
fi
