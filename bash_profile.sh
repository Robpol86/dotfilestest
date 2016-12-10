# Environment and startup programs.
# https://github.com/Robpol86/dotfiles

# If not running interactively, don't do anything.
case $- in
    *i*) ;;
      *) return;;
esac

# History.
HISTFILESIZE=200000
HISTSIZE=100000
HISTTIMEFORMAT='+%F %T '
PROMPT_COMMAND="${PROMPT_COMMAND:+$PROMPT_COMMAND;}"'echo $$ "$(history 1)" >> ~/.bash_eternal_history'
shopt -s histappend  # Append to the history file, don't overwrite it.
touch ~/.bash_eternal_history && chmod 0600 $_

# Colors and terminal.
GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'
if [[ $OSTYPE == darwin* ]]; then
    CLICOLOR=1
    LC_CTYPE=en_US.UTF-8
    LSCOLORS=gxGxFxdxbxDxDxBxBxExEx
    PS1='[\h \[\e[0;36m\]\W\[\e[0m\]]\$ '
else
    LS_COLORS="rs=0:di=38;5;27:ln=38;5;51:mh=44;38;5;15:pi=40;38;5;11:so=38;5;13:do=38;5;5:bd=48;5;232;38;5;11:cd=48;5;\
232;38;5;3:or=48;5;232;38;5;9:mi=05;48;5;232;38;5;15:su=48;5;196;38;5;15:sg=48;5;11;38;5;16:ca=48;5;196;38;5;226:tw=48;\
5;10;38;5;16:ow=48;5;10;38;5;21:st=48;5;21;38;5;15:ex=38;5;34:*.tar=38;5;9:*.tgz=38;5;9:*.arc=38;5;9:*.arj=38;5;9:*.taz\
=38;5;9:*.lha=38;5;9:*.lz4=38;5;9:*.lzh=38;5;9:*.lzma=38;5;9:*.tlz=38;5;9:*.txz=38;5;9:*.tzo=38;5;9:*.t7z=38;5;9:*.zip=\
38;5;9:*.z=38;5;9:*.Z=38;5;9:*.dz=38;5;9:*.gz=38;5;9:*.lrz=38;5;9:*.lz=38;5;9:*.lzo=38;5;9:*.xz=38;5;9:*.bz2=38;5;9:*.b\
z=38;5;9:*.tbz=38;5;9:*.tbz2=38;5;9:*.tz=38;5;9:*.deb=38;5;9:*.rpm=38;5;9:*.jar=38;5;9:*.war=38;5;9:*.ear=38;5;9:*.sar=\
38;5;9:*.rar=38;5;9:*.alz=38;5;9:*.ace=38;5;9:*.zoo=38;5;9:*.cpio=38;5;9:*.7z=38;5;9:*.rz=38;5;9:*.cab=38;5;9:*.jpg=38;\
5;13:*.jpeg=38;5;13:*.gif=38;5;13:*.bmp=38;5;13:*.pbm=38;5;13:*.pgm=38;5;13:*.ppm=38;5;13:*.tga=38;5;13:*.xbm=38;5;13:*\
.xpm=38;5;13:*.tif=38;5;13:*.tiff=38;5;13:*.png=38;5;13:*.svg=38;5;13:*.svgz=38;5;13:*.mng=38;5;13:*.pcx=38;5;13:*.mov=\
38;5;13:*.mpg=38;5;13:*.mpeg=38;5;13:*.m2v=38;5;13:*.mkv=38;5;13:*.webm=38;5;13:*.ogm=38;5;13:*.mp4=38;5;13:*.m4v=38;5;\
13:*.mp4v=38;5;13:*.vob=38;5;13:*.qt=38;5;13:*.nuv=38;5;13:*.wmv=38;5;13:*.asf=38;5;13:*.rm=38;5;13:*.rmvb=38;5;13:*.fl\
c=38;5;13:*.avi=38;5;13:*.fli=38;5;13:*.flv=38;5;13:*.gl=38;5;13:*.dl=38;5;13:*.xcf=38;5;13:*.xwd=38;5;13:*.yuv=38;5;13\
:*.cgm=38;5;13:*.emf=38;5;13:*.axv=38;5;13:*.anx=38;5;13:*.ogv=38;5;13:*.ogx=38;5;13:*.aac=38;5;45:*.au=38;5;45:*.flac=\
38;5;45:*.mid=38;5;45:*.midi=38;5;45:*.mka=38;5;45:*.mp3=38;5;45:*.mpc=38;5;45:*.ogg=38;5;45:*.ra=38;5;45:*.wav=38;5;45\
:*.axa=38;5;45:*.oga=38;5;45:*.spx=38;5;45:*.xspf=38;5;45:"
    PS1='\[\e[1;32m\]\u@\h\[\e[00m\]:\[\e[1;34m\]\W \$\[\e[0m\] '
fi

# Golang.
export GOPATH=$HOME/gocode
PATH="$PATH:$GOPATH/bin"

# Python.
test -d /Library/Frameworks/Python.framework/Versions/3.4/bin && PATH="$PATH:$_"
test -d /Library/Frameworks/Python.framework/Versions/3.5/bin && PATH="$PATH:$_"

# Bash completion.
for path in \
    "/usr/local/etc/bash_completion"\
    "/usr/share/bash-completion/bash_completion"\
    "/etc/bash_completion"\
; do test -f "$path" && source $_ && break; done
unset path

# Git prompt.
test -f /usr/share/git-core/contrib/completion/git-prompt.sh && source $_
if type __git_ps1 &> /dev/null; then
    if [[ $OSTYPE == darwin* ]]; then  # OS X.
        PS1='[\h \[\e[0;36m\]\W\[\e[0m\]$(__git_ps1 " \[\e[1;32m\](%s)\[\e[0m\]")]\$ '
    elif [ $EUID == 0 ]; then  # Linux root.
        PS1='\[\e[1;31m\]\h\[\e[00m\]:\[\e[1;34m\]\W$(__git_ps1 " (\[\e[4m\]%s\[\e[24m\])") \$\[\e[0m\] '
    else  # Linux non-root.
        PS1='\[\e[1;32m\]\u@\h\[\e[00m\]:\[\e[1;34m\]\W$(__git_ps1 " (\[\e[4m\]%s\[\e[24m\])") \$\[\e[0m\] '
    fi
fi
