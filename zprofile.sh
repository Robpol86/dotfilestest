#!/bin/zsh

# https://github.com/Robpol86/dotfiles

# PATH.
PATH="/opt/local/bin:/opt/local/sbin:$PATH:/usr/local/sbin:$HOME/bin"

# Golang.
export GOPATH=$HOME/gocode
PATH="$PATH:$GOPATH/bin"

function dcd {
    cd "$(dirname "$1")" || return "$?"
}

function _robpol86_run_once {
    echo -e "\\033[36m=> INFO: Setting git configs.\\033[0m"
    git config --global alias.exec '!exec '
    git config --global color.ui true
    git config --global core.editor vim
    git config --global core.excludesfile ~/.gitignore
    git config --global diff.tool vimdiff
    git config --global merge.tool vimdiff
    git config --global rerere.enabled true
    git config --global user.email robpol86@gmail.com
    git config --global user.name Robpol86
    test -e ~/.gitignore || echo $'.DS_Store\n.idea/\nvenv/\n.venv/' > ~/.gitignore
}
