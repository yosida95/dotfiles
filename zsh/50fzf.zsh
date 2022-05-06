if (($+commands[fzf])); then
  export FZF_DEFAULT_OPTS='--layout=reverse --prompt "QUERY> " --color=dark'

  function fzf_select_history() {
    BUFFER=$(fc -lnr 1| fzf --info=hidden --exact --no-sort --query "$LBUFFER"| sed 's/\\n/\n/g')
    CURSOR=$#BUFFER
    zle -R -c
  }
  zle -N fzf_select_history
  bindkey '^R' fzf_select_history

  if (($+commands[ghq])); then
    function fzf-ghq () {
      local selected_dir=$(ghq list| fzf --info=hidden --exact --query "$LBUFFER")
      if [ -n "$selected_dir" ]; then
        BUFFER="cd $(ghq root)/${selected_dir}"
        zle accept-line
      fi
      zle clear-screen
    }
    zle -N fzf-ghq
    bindkey '^]' fzf-ghq
  fi
fi
