zstyle ':completion:*:*:git:*' script $DOTFILES/zsh/completion/autoload/git-completion.bash

autoload -Uz +X compinit && compinit

if [ -r $DOTFILES/zsh/completion/rebar3/_rebar3 ]; then
  . $DOTFILES/zsh/completion/rebar3/_rebar3
fi

case "${commands[gcloud]}" in
  $HOME/.local/google-cloud-sdk/*)
    . "$HOME/.local/google-cloud-sdk/completion.zsh.inc"
    ;;
  /usr/bin/*)
    . "/usr/share/google-cloud-sdk/completion.zsh.inc"
    ;;
esac
