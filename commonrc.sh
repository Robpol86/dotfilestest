#!/bin/bash

# Common items sourced by bashrc and zshrc.

# Aliases.
alias lower="tr '[:upper:]' '[:lower:]'"
alias upper="tr '[:lower:]' '[:upper:]'"
if [ -n "${WSL_DISTRO_NAME:-}" ]; then
    # Aliases for WSL only.
    alias pbcopy="xsel -i --clipboard"
    alias pbpaste="xsel -o --clipboard"
fi

# Functions.
function dcd {
    cd "$(dirname "$1")" || return "$?"
}
