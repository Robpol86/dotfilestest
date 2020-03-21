#!/bin/zsh

# https://github.com/Robpol86/dotfiles
# Interactive shells.

# Colors and terminal.
CLICOLOR=1
GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'
LC_CTYPE=en_US.UTF-8
LSCOLORS=gxGxFxdxbxDxDxBxBxExEx

# Golang.
export GOPATH=$HOME/gocode
PATH="$PATH:$GOPATH/bin"

# Misc PATH.
PATH="/opt/local/bin:/opt/local/sbin:$PATH:/usr/local/sbin:$HOME/bin"
