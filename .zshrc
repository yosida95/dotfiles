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
      local version="$(tmux -V| cut -d ' ' -f 2)"
      if tmux has-session -t "$choice" 2> /dev/null; then
        if [ -z "$KITTY_PID" ] && version_at_least "$version" 3.0; then
          exec tmux attach-session -dx -t "$choice"
        else
          exec tmux attach-session -d -t "$choice"
        fi
      else
        if [ -z "$KITTY_PID" ] && version_at_least "$version" 3.0; then
          exec tmux new-session -ADX -s "$choice"
        else
          exec tmux new-session -AD -s "$choice"
        fi
      fi
    fi
  }
fi
