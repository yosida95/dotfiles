export EDITOR='vim'
export GPG_TTY=$(tty)

if (($+commands[debuild])); then
  export DEBEMAIL="kohei.yoshida@gehirn.co.jp"
  export DEBFULLNAME="Kohei YOSHIDA"
fi

if (($+commands[hg])); then
  export HGENCODING='utf-8'
fi

if (($+commands[jq])); then
  export JQ_COLORS="1;33:1;31:1;31:1;31:1;32:1;37:1;37"
fi

if (($+commands[luarocks])); then
  . <(luarocks path)
fi

if [[ (($+commands[python])) || (($+commands[python3])) ]]; then
  export VIRTUAL_ENV_DISABLE_PROMPT=1
  export PIPENV_VENV_IN_PROJECT="1"
  export PIPENV_VERBOSITY="-1"
fi

if (($+commands[atuin])); then
  . <(atuin init zsh --disable-up-arrow)
fi

if (($+commands[fzf])); then
  export FZF_DEFAULT_OPTS='--exact --layout=reverse --height=100% --info=hidden --prompt "QUERY> " --color=dark'
  export FZF_CTRL_R_OPTS='--no-sort'

  if ! (($+commands[atuin])); then
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
      local repo=$(ghq list| fzf --query "$LBUFFER")
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

if (($+commands[uv])); then
  export UV_PYTHON_DOWNLOADS="manual"
fi
