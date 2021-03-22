DOTFILES="${$(print -P %N):A:h}"

export LANG=en_US.UTF-8
export LANGUAGE=$LANG
export LC_ALL=$LANG

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

# EDITOR
export EDITOR='vim'

# Mercurial
export HGENCODING='utf-8'

# Go
export GOPATH=$HOME/proj
export GOBIN=$GOPATH/bin

# debuild
export DEBEMAIL="kohei.yoshida@gehirn.co.jp"
export DEBFULLNAME="Kohei YOSHIDA"

# https://github.com/motemen/ghq
export GHQ_ROOT=$HOME/proj/src

export GOPRIVATE=github.com/yosida95,github.com/GehirnInc
