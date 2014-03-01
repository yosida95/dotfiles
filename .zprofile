export LANG=en_US.UTF-8
export LANGUAGE=$LANG
export LC_ALL=$LANG

##############################
#            PATH            #
##############################
PY2ROOT=/opt/python/2.7
PY3ROOT=/opt/python/3.3
export GOROOT=/opt/go/1.2
NODEROOT=/opt/node/0.8
ERLROOT=/opt/erlang/r16b
GHCROOT=/opt/haskell/ghc/7.4
HSPFROOT=/opt/haskell/platform/2012.02.0.0
PBROOT=/opt/protobuf/2.5
export PATH=$PY2ROOT/bin:$PY3ROOT/bin:$GOROOT/bin:$NODEROOT/bin:$ERLROOT/bin:$GHCROOT/bin:$HSPFROOT/bin:$PBROOT/bin:$HOME/bin:$PATH

# EDITOR
export EDITOR='vim'

# Mercurial
export HGENCODING='utf-8'

##############################
#         VIRTUALENV         #
##############################
export VIRTUAL_ENV_DISABLE_PROMPT=1
export WORKON_HOME=$HOME/.virtualenvs
export VIRTUALENVWRAPPER_LOG_DIR=$WORKON_HOME
export VIRTUALENVWRAPPER_PYTHON=$PY2ROOT/bin/python

case "${OSTYPE}" in
    darwin*)
        export PATH=/usr/local/bin:/usr/local/sbin:$PATH
        ;;
    linux*)
        ;;
esac
