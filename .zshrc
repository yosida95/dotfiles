# Path to your oh-my-zsh configuration.
ZSH=$HOME/src/dotfiles/oh-my-zsh
ZSH_CUSTOM=$HOME/src/dotfiles/oh-my-zsh_custom

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="yosida95"

# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Comment this out to disable bi-weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

# Uncomment to change how often before auto-updates occur? (in days)
# export UPDATE_ZSH_DAYS=13

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want to disable command autocorrection
# DISABLE_CORRECTION="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
# COMPLETION_WAITING_DOTS="true"

# Uncomment following line if you want to disable marking untracked files under
# VCS as dirty. This makes repository status check for large repositories much,
# much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(brew celery coffee django docker git git-flow github go go-prompt history history-substring-search mercurial node npm osx pip python python-prompt rsync supervisor urltools virtualenv virtualenvwrapper vi-mode yum)

# PATH
PY2ROOT=/opt/python/2.7
PY3ROOT=/opt/python/3.2
export GOROOT=/opt/go/1.1
NODEROOT=/opt/node/0.8
ERLROOT=/opt/erlang/r16b
GHCROOT=/opt/haskell/ghc/7.4
HSPFROOT=/opt/haskell/platform/2012.02.0.0
PBROOT=/opt/protobuf/2.5
export PATH=$PY2ROOT/bin:$PY3ROOT/bin:$GOROOT/bin:$NODEROOT/bin:$ERLROOT/bin:$GHCROOT/bin:$HSPFROOT/bin:$PBROOT/bin:$HOME/bin:$PATH

source $ZSH/oh-my-zsh.sh

# Customize to your needs...
source $HOME/.zshrc.mine

case "${OSTYPE}" in
    darwin*)
        source $HOME/.zshrc.osx
        ;;
    linux*)
        source $HOME/.zshrc.linux
        ;;
esac
