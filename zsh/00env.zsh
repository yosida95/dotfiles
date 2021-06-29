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
