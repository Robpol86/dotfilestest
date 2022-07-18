#!/usr/bin/env bash

# Install dotfiles.
#
# Supported environments:
#   * GitHub codespaces with zsh
#   * General purpose machines with zsh (if installed) or bash

set -o errexit  # Exit script if a command fails.
set -o nounset  # Treat unset variables as errors and exit immediately.
set -o pipefail  # Exit script if pipes fail instead of just the last program.
set -o xtrace  # Print commands before executing them.

CODESPACES="${CODESPACES:-}"
HERE="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
NAME="$(basename "${BASH_SOURCE[0]}")"
ZSH="${ZSH:-"$HOME/.oh-my-zsh"}"
ZSH_CUSTOM="${ZSH_CUSTOM:-"$ZSH/custom"}"

# Configure VS Code defaults if running from GitHub codespace.
gh_cs_vscode_defaults() {
    if [ -z "$CODESPACES" ]; then
        return  # Not running from GitHub codespace.
    fi
    local settings_json="$HOME/.vscode-remote/data/Machine/settings.json"

    echo "Pre-configuring VS Code"
    jq -rsS ".[0] * .[1]" "$settings_json" "$HERE/settings-gh-cs.json" > "$settings_json.new"
    mv -v "$settings_json.new" "$settings_json"

    # echo "Restarting VS Code"
    # ps ux |grep vscode-remote |awk '{print $2}' |xargs kill  # TODO better
}

# Setup shell-agnostic dotfiles.
dotfiles_common() {
    echo "Symlinking common dotfiles"

    # SSH
    if [ -e "$HOME/.ssh/config" ] && [ ! -L "$HOME/.ssh/config" ]; then
        echo "SSH config exists, aborting" >&2
        exit 1
    fi
    install -m0700 -d "$HOME/.ssh"
    ln -fsv "$HERE/ssh_config" "$HOME/.ssh/config"

    # VIM
    ln -fsv "$HERE/vimrc" "$HOME/.vimrc"
}

# Setup bash dotfiles.
dotfiles_bash() {
    :  # TODO
}

# Setup zsh dotfiles.
dotfiles_zsh() {
    :  # TODO cli argument requiring zsh or not?
}

# Main function.
main() {
    echo "🔃 Begin installing dotfiles via $NAME..."
    dotfiles_common
    dotfiles_bash
    dotfiles_zsh
    gh_cs_vscode_defaults
    echo "✅ Done installing dotfiles via $NAME..."

#    # Install OMZ.
#    command -v zsh || command "$_"  # Print error if zsh command not found.
#    if [ -n "$CODESPACES" ]; then  # Running from a GitHub codespace. OMZ is pre-installed, just change shell.
#        echo "Changing codespace shell to zsh"
#        sudo chsh -s "$(command -v zsh)" "$USER"
#    elif [ ! -e "$ZSH" ]; then  # OMZ not installed, installing.
#        echo "Installing Oh My Zsh"
#        sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
#    else  # OMZ already installed.
#        echo "Oh My Zsh is already installed"
#    fi
#
#    echo "Installing plugins"
#    test -e "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting" ||
#        git clone --depth=1 "https://github.com/zsh-users/zsh-syntax-highlighting.git" "$_"
#    test -e "$ZSH_CUSTOM/plugins/diff-so-fancy" ||
#        git clone --depth=1 "https://github.com/so-fancy/diff-so-fancy.git" "$_"  # Not really a zsh plugin.
#    echo "Symlinking theme"
#    ln -fsv "$HERE/robpol86.zsh-theme" "$ZSH_CUSTOM/themes/robpol86.zsh-theme"
#
#    echo "Symlinking other files"
#    ln -fsv "$HERE/zshrc.sh" "$HOME/.zshrc"
#    ln -fsv "$HERE/zprofile.sh" "$HOME/.zprofile"
#
#    echo "Configuring git"
#    zsh -lc "_robpol86_git_config '$ZSH_CUSTOM'"
}

# Run.
main
