# deduplicate $PATH and $FPATH. Keep the first (left most) occurrence.
typeset -U PATH path
typeset -U FPATH fpath

fpath=(
  ${DOTFILES}/zsh/completion/autoload
  ${DOTFILES}/zsh/_functions
  $fpath
)

for config in $DOTFILES/zsh/*.zsh(N.onn); do
  source $config
done
unset config

# Load custom shell functions
autoload -Uz $DOTFILES/zsh/_functions/*(:t)

update-ssh-auth-sock

if [ -z "$TMUX" ] && (($+commands[tmux])); then
  () {
    (tmux list-session 2>/dev/null || :)| sed -e $'s/^/\t/g'

    local choice
    read 'choice?> '
    if [ -n "$choice" ]; then
      local version="$(tmux -V| cut -d ' ' -f 2)"
      if tmux has-session -t "$choice" 2> /dev/null; then
        exec tmux attach-session -d -t "$choice"
      else
        exec tmux new-session -AD -s "$choice"
      fi
    fi
  }
fi
