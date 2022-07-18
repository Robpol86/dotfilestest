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
ZSH="${ZSH:-~/.oh-my-zsh}"
ZSH_CUSTOM="${ZSH_CUSTOM:-"$ZSH/custom"}"

# Setup shell-agnostic dotfiles.
dotfiles_common() {
    echo "⏩ Setup ssh config"
    if [ -e ~/.ssh/config ] && [ ! -L ~/.ssh/config ]; then
        echo "❌ SSH config already exists, aborting" >&2
        exit 1
    fi
    install -m0700 -d ~/.ssh
    ln -fsv "$HERE/ssh_config" ~/.ssh/config

    echo "⏩ Setup vim config"
    ln -fsv "$HERE/vimrc" ~/.vimrc

    echo "⏩ Setup git diff formatter"
    curl -sSfL "https://github.com/so-fancy/diff-so-fancy/releases/latest/download/diff-so-fancy" -o ~/.git-diff-so-fancy
    chmod +x ~/.git-diff-so-fancy
    git config --global core.pager "$HOME/.git-diff-so-fancy |less --tabs=4 -RFX"
}

# Setup bash dotfiles.
dotfiles_bash() {
    :  # TODO
}

# Setup zsh dotfiles.
dotfiles_zsh() {
    :  # TODO cli argument requiring zsh or not?
}

# Configure VS Code defaults.
vscode_defaults() {
    echo "Pre-configuring VS Code"
    local settings_json=~/.vscode-remote/data/Machine/settings.json
    jq -rsS ".[0] * .[1]" "$settings_json" "$HERE/settings-gh-cs.json" > "$settings_json.new"
    mv -v "$settings_json.new" "$settings_json"

    # echo "Restarting VS Code"
    # ps ux |grep vscode-remote |awk '{print $2}' |xargs kill  # TODO better
}

# Main function.
main() {
    echo "🔃 Begin installing dotfiles via $NAME..."
    dotfiles_common
    dotfiles_bash
    dotfiles_zsh
    if [ -n "$CODESPACES" ]; then
        vscode_defaults
    fi
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
#    echo "Symlinking theme"
#    ln -fsv "$HERE/robpol86.zsh-theme" "$ZSH_CUSTOM/themes/robpol86.zsh-theme"
#
#    echo "Symlinking other files"
#    ln -fsv "$HERE/zshrc.sh" "~/.zshrc"
#    ln -fsv "$HERE/zprofile.sh" "~/.zprofile"
#
#    echo "Configuring git"
#    zsh -lc "_robpol86_git_config '$ZSH_CUSTOM'"
}

# Run.
main
