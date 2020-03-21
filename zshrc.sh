#!/bin/zsh

# https://github.com/Robpol86/dotfiles

alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'
alias grep='grep --color=auto'
alias lower="tr '[:upper:]' '[:lower:]'"
alias upper="tr '[:lower:]' '[:upper:]'"

if [[ $OSTYPE == darwin* ]]; then
    alias ls='ls -G'
else
    alias ls='ls --color=auto'
fi

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
    echo $'.DS_Store\n.idea/\nvenv/\n.venv/' > ~/.gitignore
}

# History.
HISTSIZE=10000  # Number of lines kept in memory.
SAVEHIST=999999  # Number of lines stored on disk.
setopt extended_history  # Timestamps in history file.
setopt hist_ignore_all_dups
setopt share_history  # All terminals share the same history.

# Prompt.
source /usr/share/git-core/contrib/completion/git-prompt.sh 2> /dev/null || \
    source /Library/Developer/CommandLineTools/usr/share/git-core/git-prompt.sh 2> /dev/null
setopt prompt_subst
type __git_ps1 &> /dev/null || __git_ps1() { :; }
PS1="[%m %F{cyan}%1~%f$(__git_ps1 " %%B%%F{green}(%s)%%f%%b")]%# "
