# vim: set filetype=zsh :

export LANG=en_US.UTF-8
export LANGUAGE=$LANG
export LC_ALL=$LANG

if (($+commands[dircolors])); then
    eval "$(dircolors $HOME/.dircolors)"
elif (($+commands[gdircolors])); then
    eval "$(gdircolors $HOME/.dircolors)"
fi
export ZLS_COLORS="$LS_COLORS"
export LSCOLORS="Gxfxcxdxbxegedabagacad"

export LESS='-R'
export LESSCHARSET=utf-8

# EDITOR
export EDITOR='vim'

# Mercurial
export HGENCODING='utf-8'

# debuild
export DEBEMAIL="kohei.yoshida@gehirn.co.jp"
export DEBFULLNAME="Kohei YOSHIDA"

# ghq
export GHQ_ROOT=$HOME/proj/src
