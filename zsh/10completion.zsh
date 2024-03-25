zstyle ':completion:*:*:git:*' script $DOTFILES/zsh/completion/git-completion.bash

autoload -Uz +X compinit && compinit
