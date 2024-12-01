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
