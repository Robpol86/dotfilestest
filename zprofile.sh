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

function _robpol86_git_config {
    echo -e "\\033[36m=> INFO: Setting git configs.\\033[0m"
    git config --global alias.exec '!exec '
    git config --global alias.set-upstream '!git branch --set-upstream-to=origin/$(git symbolic-ref --short HEAD)'
    git config --global color.ui true
    git config --global core.editor vim
    git config --global core.excludesfile ~/.gitignore
    git config --global diff.tool vimdiff
    git config --global merge.tool vimdiff
    git config --global rerere.enabled true
    git config --global user.email robpol86@gmail.com
    git config --global user.name Robpol86
    test -e ~/.gitignore || echo $'.DS_Store\n.idea/\nvenv/\n.venv/' > ~/.gitignore
    git config --global color.diff-highlight.newHighlight   "black 40"
    git config --global color.diff-highlight.newNormal      "green bold"
    git config --global color.diff-highlight.oldHighlight   "black 160"
    git config --global color.diff-highlight.oldNormal      "red bold"
    git config --global color.diff.commit       "yellow bold"
    git config --global color.diff.frag         "magenta bold"
    git config --global color.diff.meta         "11"
    git config --global color.diff.new          "green bold"
    git config --global color.diff.old          "red bold"
    git config --global color.diff.whitespace   "red reverse"
    git config --global color.ui    "true"

    echo -e "\\033[36m=> INFO: Enabling git diff-so-fancy.\\033[0m"
    local pager="${1:-"$ZSH_CUSTOM"}/plugins/diff-so-fancy/diff-so-fancy"
    if [ ! -e "$pager" ]; then
        echo -e "\\033[31m=> ERROR: Pager file not found: $pager\\033[0m"
        return 1
    fi
    git config --global core.pager "$pager |less --tabs=4 -RFX"
}
