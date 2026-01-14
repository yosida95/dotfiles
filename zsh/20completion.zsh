zstyle ':completion:*:*:git:*' script $DOTFILES/zsh/completion/autoload/git-completion.bash

autoload -Uz +X compinit && compinit

if [ -r $DOTFILES/zsh/completion/_rebar3 ]; then
  . $DOTFILES/zsh/completion/_rebar3
fi

if (($+commands[terraform])); then
  autoload -U +X bashcompinit && bashcompinit
  complete -o nospace -C "$commands[terraform]" terraform
fi
