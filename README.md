# dotfiles

My dotfiles. Nothing special.

Used on OS X and Linux (Fedora/RHEL/Centos/Ubuntu/Debian).

## Install

```shell
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git \
    "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting"
git clone git@github.com:Robpol86/dotfiles.git "$HOME/workspace/dotfiles" && cd "$_" && \
    install -m0700 -d ~/.ssh && \
    ln -s "$PWD/ssh_config" ~/.ssh/config && \
    ln -fs "$PWD/vimrc" ~/.vimrc && \
    ln -fs "$PWD/themes/robpol86.zsh-theme" "$ZSH/custom/themes/" && \
    ln -fs "$PWD/zshrc.sh" ~/.zshrc && \
    ln -fs "$PWD/zprofile.sh" ~/.zprofile && \
    zsh -lc _robpol86_run_once
```
