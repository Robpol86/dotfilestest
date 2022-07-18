#!/bin/zsh

# https://github.com/Robpol86/dotfiles

# PATH.
PATH="/opt/local/bin:/opt/local/sbin:$PATH:/usr/local/sbin:$HOME/bin:$HOME/.local/bin:/usr/local/go/bin:$HOME/.poetry/bin"

# Golang.
export GOPATH=$HOME/gocode
PATH="$PATH:$GOPATH/bin"

function dcd {
    cd "$(dirname "$1")" || return "$?"
}
