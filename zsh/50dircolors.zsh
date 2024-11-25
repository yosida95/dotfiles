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
