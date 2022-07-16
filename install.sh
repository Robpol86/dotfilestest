#!/usr/bin/env bash

# Install dotfiles and changes shell to zsh.
#
# For use with GitHub Codespaces as well as local development machines.

set -o errexit  # Exit script if a command fails.
set -o nounset  # Treat unset variables as errors and exit immediately.
set -o pipefail  # Exit script if pipes fail instead of just the last program.
set -o xtrace  # Print commands before executing them.

CODESPACES="${CODESPACES:-}"
HERE="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
NAME="$(basename "${BASH_SOURCE[0]}")"
ZSH="${ZSH:-"$HOME/.oh-my-zsh"}"
ZSH_CUSTOM="${ZSH_CUSTOM:-"$ZSH/custom"}"

# Print error to stderr.
error() (
    { set +x; } 2>/dev/null
    printf '\e[31m=> %02d:%02d:%02d ERROR: %s\e[0m\n' $((SECONDS/3600)) $((SECONDS%3600/60)) $((SECONDS%60)) "$*" >&2
)

# Print error to stderr and exit 1.
errex() {
    error "$*"
    exit 1
}

# Print warning to stderr.
warning() (
    { set +x; } 2>/dev/null
    printf '\e[33m=> %02d:%02d:%02d WARNING: %s\e[0m\n' $((SECONDS/3600)) $((SECONDS%3600/60)) $((SECONDS%60)) "$*" >&2
)

# Print normal messages to stdout.
info() (
    { set +x; } 2>/dev/null
    printf '\e[36m=> %02d:%02d:%02d INFO: %s\e[0m\n' $((SECONDS/3600)) $((SECONDS%3600/60)) $((SECONDS%60)) "$*"
)

# Verify source path exists and then symlink it to the target path.
symlink() {
    test -e "$1" || errex "File not found: $1"
    ln -fsv "$1" "$2"
}

# Git clone or pull if already cloned.
clone_or_pull() {
    url="$1"
    dir="$2"
    if [ ! -e "$dir" ]; then
        git clone --depth=1 "$url" "$dir"
    else
        git -C "$dir" pull
    fi
}

# Main function.
main() {
    # Install OMZ.
    command -v zsh || command "$_"  # Print error if zsh command not found.
    if [ -n "$CODESPACES" ]; then  # Running from a GitHub codespace. OMZ is pre-installed, just change shell.
        info "Changing codespace shell to zsh"
        sudo chsh -s "$(command -v zsh)" "$USER"
    elif [ ! -e "$ZSH" ]; then  # OMZ not installed, installing.
        info "Installing Oh My Zsh"
        sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
    else  # OMZ already installed.
        info "Oh My Zsh is already installed"
    fi

#    info Installing Zsh and Git plugins
#    clone_or_pull https://github.com/zsh-users/zsh-syntax-highlighting.git "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting"
#    clone_or_pull https://github.com/so-fancy/diff-so-fancy.git "$ZSH_CUSTOM/plugins/diff-so-fancy"  # Not really a zsh plugin.
#    symlink "$HERE/themes/robpol86.zsh-theme" "$ZSH_CUSTOM/themes/robpol86.zsh-theme"
#
#    info Symlinking dotfiles
#    symlink "$HERE/vimrc" "$HOME/.vimrc"
#    symlink "$HERE/zshrc.sh" "$HOME/.zshrc"
#    symlink "$HERE/zprofile.sh" "$HOME/.zprofile"
#
#    info Install SSH config
#    install -m0700 -d "$HOME/.ssh"
#    symlink "$HERE/ssh_config" "$HOME/.ssh/config"
#
#    info Execute run-once commands
#    zsh -lc _robpol86_run_once
}

info "Begin installing dotfiles via $NAME..."
main
info "Done installing dotfiles via $NAME..."
