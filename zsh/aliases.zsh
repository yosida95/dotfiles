# vim: set filetype=zsh :

if ! ( (($+commands[brew])) && [ -d "$(brew --prefix coreutils)" ] ); then
    alias ls='ls -G'
else
    alias ls='ls --color=auto'
fi

alias du="du -h"
alias df="df -h"
alias la='ls -Ah'
alias lf="ls -F"
alias ll='ls -hl'
alias su="su -l"
alias where="command -v"

alias grep='grep --color=auto --exclude-dir={.bzr,.cvs,.git,.hg,.svn}'

alias -s {png,gif,jpg,bmp,PNG,GIF,JPG,BMP}=eog
alias -s html=google-chrome
