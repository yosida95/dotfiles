if (($+commands[peco])); then
  function peco_select_history() {
    BUFFER=$(fc -lnr 1| peco --query "$LBUFFER"| sed 's/\\n/\n/g')
    CURSOR=$#BUFFER
    zle -R -c
  }
  zle -N peco_select_history
  bindkey '^R' peco_select_history

  if (($+commands[ghq])); then
    function peco-src () {
      local selected_dir=$(ghq list -p | peco --query "$LBUFFER")
      if [ -n "$selected_dir" ]; then
        BUFFER="cd ${selected_dir}"
        zle accept-line
      fi
      zle clear-screen
    }
    zle -N peco-src
    bindkey '^]' peco-src
  fi
fi
