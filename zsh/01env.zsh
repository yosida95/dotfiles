if (($+commands[dircolors])); then
  . <(dircolors $HOME/.dircolors)
elif (($+commands[gdircolors])); then
  . <(gdircolors $HOME/.dircolors)
fi
export ZLS_COLORS="$LS_COLORS"
export LSCOLORS="Gxfxcxdxbxegedabagacad"

export LESS='-giMR'
export LESSCHARSET=utf-8
export LESSOPEN="| ${DOTFILES}/lesspipe.sh %s"

export EDITOR='vim'
export GPG_TTY=$(tty)

export FZF_DEFAULT_OPTS='--layout=reverse --prompt "QUERY> " --color=dark'

export JQ_COLORS="1;33:1;31:1;31:1;31:1;32:1;37:1;37"
