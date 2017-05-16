# vim: set filetype=zsh :

if (($+commands[brew])) && [ ! -d "$(brew --prefix coreutils)" ]; then
    alias ls='ls -G'
else
    alias ls='ls --color=auto'
fi

alias du="du -h"
alias df="df -h"
alias la='ls -Ah'
alias ll='ls -hl'
alias where="command -v"
alias grep='grep --color=auto --exclude-dir={.bzr,.cvs,.git,.hg,.svn}'
alias urlsafe_b64encode="base64| tr '+' '-'| tr '/' '_'"
