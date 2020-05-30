DOTFILES="${$(print -P %N):A:h}"
FPATH="${DOTFILES}/zsh/completion:${DOTFILES}/zsh/_functions:/usr/share/zsh/site-functions:${FPATH}"

for config in $DOTFILES/zsh/**/*.zsh; do
  source $config
done
unset config

# Load custom shell functions
autoload -U $DOTFILES/zsh/_functions/*(:t)

if [ -S "$XDG_RUNTIME_DIR/ssh-agent.socket" ]; then
  export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.socket"
fi

gopath $HOME/proj

if [ -z "$TMUX" ] && (($+commands[tmux])); then
  sessions=$(tmux list-session 2>/dev/null)
  if [ -n $sessions ]; then
    echo $sessions| sed -e $'s/^/\t/g'
  fi
  unset sessions

  echo -n "> "
  read choice
  if tmux has-session -t $choice 2>/dev/null; then
    exec tmux attach-session -t $choice
  elif [ -n "$choice" ]; then
    exec tmux new-session -s $choice
  fi
  unset choice
fi
