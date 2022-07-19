#!/bin/bash

# Environment and startup programs.
# https://github.com/Robpol86/dotfiles

# History.
HISTFILESIZE=200000
HISTSIZE=100000
HISTTIMEFORMAT='+%F %T '
PROMPT_COMMAND="${PROMPT_COMMAND:+$PROMPT_COMMAND;}"'echo $$ "$(history 1)" >> ~/.bash_eternal_history'
shopt -s histappend  # Append to the history file, don't overwrite it.
touch ~/.bash_eternal_history && chmod 0600 "$_"  # Don't use `install`.

# Golang.
export GOPATH=$HOME/gocode
PATH="$PATH:$GOPATH/bin"

# Python.
test -d /Library/Frameworks/Python.framework/Versions/3.4/bin && PATH="$PATH:$_"
test -d /Library/Frameworks/Python.framework/Versions/3.5/bin && PATH="$PATH:$_"

# Misc PATH.
PATH="$PATH:/usr/local/sbin:$HOME/bin"

# Bash completion.
for path in /usr/local/etc/bash_completion /usr/share/bash-completion/bash_completion /etc/bash_completion; do
    # shellcheck disable=SC1090
    source "$path" 2> /dev/null && break
done
unset path
# shellcheck disable=SC1091
source /usr/share/git-core/contrib/completion/git-prompt.sh 2> /dev/null

# Prompt.
PS1=
if type __git_ps1 &> /dev/null; then
    if [[ $OSTYPE == darwin* ]]; then
        PS1='$(__git_ps1 " \[\e[1;32m\](%s)\[\e[0m\]")'
    else
        PS1='$(__git_ps1 " (\[\e[4m\]%s\[\e[24m\])")'
    fi
fi
if [[ $OSTYPE == darwin* ]]; then
    PS1='[\h \[\e[0;36m\]\W\[\e[0m\]'"$PS1"']\$ '
elif [ $EUID == 0 ]; then  # Linux root.
    PS1='\[\e[1;31m\]\h\[\e[00m\]:\[\e[1;34m\]\W'"$PS1"' \$\[\e[0m\] '
else  # Linux non-root.
    PS1='\[\e[1;32m\]\u@\h\[\e[00m\]:\[\e[1;34m\]\W'"$PS1"' \$\[\e[0m\] '
fi

#################################### GITHUB ####################################

# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
        . "$HOME/.bashrc"
    fi
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin:$PATH"
fi