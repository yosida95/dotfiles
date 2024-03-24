DOTFILES="${$(print -P %N):A:h}"

export LANG=en_US.UTF-8
export LANGUAGE=$LANG
export LC_ALL=$LANG

# Mercurial
export HGENCODING='utf-8'

# Go
export GOPATH=$HOME/proj
export GOBIN=$GOPATH/bin
export GOPRIVATE=github.com/yosida95,github.com/GehirnInc

# debuild
export DEBEMAIL="kohei.yoshida@gehirn.co.jp"
export DEBFULLNAME="Kohei YOSHIDA"

# Prevent compinit from being called in /etc/zshrc on Ubuntu
if grep -q '^ID.*=.*ubuntu' /etc/os-release 2>/dev/null; then
  skip_global_compinit=1
fi
