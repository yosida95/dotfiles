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
fixsshauthsock

if [ -z "$TMUX" ] && (($+commands[tmux])); then
  () {
    (tmux list-session 2>/dev/null || :)| sed -e $'s/^/\t/g'

    local choice
    read 'choice?> '
    if [ -n "$choice" ]; then
      if tmux has-session -t "$choice" 2> /dev/null; then
        exec tmux attach-session -dx -t "$choice"
      else
        exec tmux new-session -ADX -s "$choice"
      fi
    fi
  }
fi
