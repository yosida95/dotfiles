zstyle ':completion:*:*:git:*' script $DOTFILES/zsh/completion/autoload/git-completion.bash

autoload -Uz +X compinit && compinit

if [ -r $DOTFILES/zsh/completion/_rebar3 ]; then
  . $DOTFILES/zsh/completion/_rebar3
fi
