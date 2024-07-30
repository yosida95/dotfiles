zstyle ':completion:*:*:git:*' script $DOTFILES/zsh/completion/autoload/git-completion.bash

autoload -Uz +X compinit && compinit
