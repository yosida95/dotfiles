if (($+commands[fzf])); then
  export FZF_DEFAULT_OPTS='--exact --layout=reverse --prompt "QUERY> " --color=dark'
  export FZF_CTRL_R_OPTS='--info=hidden --height=100% --no-sort'

  if fzf --zsh >/dev/null 2>&1; then
    . <(fzf --zsh)
  else
    function fzf_select_history() {
      BUFFER=$(fc -lnr 1| FZF_DEFAULT_OPTS="${FZF_DEFAULT_OPTS} ${FZF_CTRL_R_OPTS}" fzf --query "$LBUFFER"| sed 's/\\n/\n/g')
      CURSOR=$#BUFFER
      zle -R -c
    }
    zle -N fzf_select_history
    bindkey '^R' fzf_select_history
  fi

  if (($+commands[ghq])); then
    function fzf-ghq () {
      local repo=$(ghq list| fzf --info=hidden --query "$LBUFFER")
      if [ -n "$repo" ]; then
        BUFFER="cd -- $(ghq root)/${(q)repo}"
        zle accept-line
      fi
      zle reset-prompt
    }
    zle -N fzf-ghq
    bindkey '^]' fzf-ghq
  fi
fi
