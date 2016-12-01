# Functions and aliases.
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

function _robpol86_run_once {
    git config --global alias.exec '!exec '
    git config --global color.ui true
    git config --global core.editor vim
    git config --global core.excludesfile '~/.gitignore'
    git config --global diff.tool vimdiff
    git config --global merge.tool vimdiff
    git config --global rerere.enabled true
    git config --global user.email robpol86@gmail.com
    git config --global user.name Robpol86
    for path in $(find /usr -type f -name diff-highlight 2>/dev/null)
    do if [ -f ${path} ]; then
        git config --global pager.diff "perl $path |less"
        git config --global pager.show "perl $path |less"
        git config --global pager.log "perl $path |less"
    fi; done
}
