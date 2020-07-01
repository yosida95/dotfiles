if ls -f --color >/dev/null 2>&1; then
  alias ls='ls --color=auto'  # GNU ls
else
  alias ls='ls -G'  # BSD ls
fi
alias la='ls -Ah'
alias ll='ls -hl'

alias du="du -h"
alias df="df -h"
alias where="command -v"
alias grep='grep --color=auto --exclude-dir={.bzr,.cvs,.git,.hg,.svn}'
alias urlsafe_b64encode="base64| tr '+' '-'| tr '/' '_'"

if [[ "$(uname)" == "Darwin" ]]; then
  alias vlc="osascript ${DOTFILES}/macos/vlc.scpt"
fi
