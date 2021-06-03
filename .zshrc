# deduplicate $FPATH (keep the first occurrence)
typeset -U FPATH fpath
fpath=(
  ${DOTFILES}/zsh/completion
  ${DOTFILES}/zsh/_functions
  /usr/local/share/zsh/site-functions(N-/:a)
  $fpath
)

for config in $DOTFILES/zsh/*.zsh; do
  source $config
done
unset config

# Load custom shell functions
autoload -Uz $DOTFILES/zsh/_functions/*(:t)

if [ -z "$SSH_AUTH_SOCK" ] && [ -S "$XDG_RUNTIME_DIR/ssh-agent.socket" ]; then
  export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.socket"
fi

if [ -z "$TMUX" ] && (($+commands[tmux])); then
  () {
    local sessions
    local choice

    sessions=$(tmux list-session 2>/dev/null)
    if [ -n $sessions ]; then
      echo $sessions| sed -e $'s/^/\t/g'
    fi

    read 'choice?> '
    if [ -n "$choice" ]; then
      if [ -S "$SSH_AUTH_SOCK" ] && [[ $SSH_AUTH_SOCK = /tmp/ssh-*/agent.* ]]; then
        ln -sfn "$SSH_AUTH_SOCK" "$XDG_RUNTIME_DIR/ssh-agent.socket"
        export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.socket"
      fi
      if tmux has-session -t $choice 2>/dev/null; then
        exec tmux attach-session -t $choice
      else
        exec tmux new-session -s $choice
      fi
    fi
  }
fi
