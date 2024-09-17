if [[ -f "$HOME/.dircolors"  && ( (($+commands[dircolors])) || (($+commands[gdircolors])) ) ]]; then
  if (($+commands[dircolors])); then
    . <(dircolors $HOME/.dircolors)
  else
    . <(gdircolors $HOME/.dircolors)
  fi

  zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
fi

if [ "$(uname)" = "Darwin" ]; then
  export LSCOLORS="Gxfxcxdxbxegedabagacad"
fi

export LESS='-giMR'
export LESSCHARSET=utf-8

if (($+commands[lesspipe])); then
  . <(lesspipe)
elif (($+commands[lesspipe.sh])); then
  . <(lesspipe.sh)
fi

export EDITOR='vim'
export GPG_TTY=$(tty)

export JQ_COLORS="1;33:1;31:1;31:1;31:1;32:1;37:1;37"

export VIRTUAL_ENV_DISABLE_PROMPT=1
export PIPENV_VENV_IN_PROJECT="1"
export PIPENV_VERBOSITY="-1"
