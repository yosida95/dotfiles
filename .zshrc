# Path to your oh-my-zsh configuration.
BASEDIR=$HOME/src/dotfiles
ZSH=$BASEDIR/oh-my-zsh
ZSH_CUSTOM=$BASEDIR/oh-my-zsh_custom

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

# Uncomment this to disable bi-weekly auto-update checks
DISABLE_AUTO_UPDATE="true"

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

# Uncomment following line if you want to  shown in the command execution time stamp 
# in the history command output. The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|
# yyyy-mm-dd
# HIST_STAMPS="mm/dd/yyyy"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(brew celery docker gitignore go npm osx pip python rebar sbt scala rbenv supervisor urltools)

source $ZSH/oh-my-zsh.sh

# User configuration

autoload -Uz colors

##############################
#         Completion         #
##############################
autoload -U compinit
compinit

setopt correct  # Correcting spell miss
setopt list_packed  # show candidacy compactly
setopt nolistbeep  # show candidacy without beep
setopt auto_menu  # Automatically use menu completion after the second consecutive request for completion, for example by pressing the TAB key repeatedly. This option is overridden by MENU_COMPLETE.
setopt auto_param_keys  # If a parameter name was completed and the next character typed is one of those that have to come directly after the name (like }, :, etc.), they are placed there automatically.
setopt auto_param_slash  # if a parameter is completed whose content is the name of a directory, then add a trailing slash.
setopt auto_remove_slash  # When the last character resulting from a completion is a slash and the next character typed is a word delimiter, remove the slash.
setopt mark_dirs  # Append a trailing / to all directory names resulting from filename generation.
setopt list_types  # When listing files that are possible completions, show the type of each file with a trailing identifying mark.
setopt complete_in_word  # If unset, the cursor is moved to the end of the word if completion is started. Otherwise it stays where it is and completion is done from both ends.
setopt print_eight_bit
setopt magic_equal_subst  # All unquoted arguments of the form identifier=expression appearing after the command name have file expansion (that is, where expression has a leading `~' or `=') performed on expression as if it were a parameter assignment. The argument is not otherwise treated specially: in other words, it is subsequently treated as a single word, not as an assignment.
unsetopt menu_complete  # On an ambiguous completion, instead of listing possibilities or beeping, insert the first match immediately. Then when completion is requested again, remove the first match and insert the second match, etc. When there are no more matches, go back to the first one again. reverse-menu-complete may be used to loop through the list in the other direction. This option overrides AUTO_MENU.

autoload -Uz url-quote-magic
zle -N self-insert url-quote-magic

if [[ "${OSTYPE}" = linux* ]]; then
    zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}  # 補完候補を色付き表示
fi
zstyle ':completion:*' use-cache true  # cache candidacy of completion
zstyle ':completion:*:processes' command 'ps x'  # kill で 'ps x' のリストから選択可能
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([%0-9]#)*=0=01;31'  # kill の候補を色付き表示

##############################
#          History           #
##############################
HISTFILE=$HOME/.zsh_history  # file for saving history
SAVEHIST=10000  # count of history saved on HISTFILE
HISTSIZE=10000  # count of history saved on memory
setopt share_history  # share history among other terminal
# setopt hist_expand
# setopt append_history
setopt inc_append_history # history will be saved on HISTFILE incrementally
setopt hist_ignore_all_dups  # remove duplicate from history
setopt hist_ignore_dups  # if command matches latest history, it is not append to history
setopt hist_save_no_dups  # remove duplicate from HISTFILE
setopt hist_ignore_space  # if command starts with space, it is not append to history
setopt hist_reduce_blanks  # history will be stripped
setopt hist_no_store  # "history" command will not be recorded on history

autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^P" history-beginning-search-backward-end  # select previous history with Ctrl-P
bindkey "^N" history-beginning-search-forward-end  # select next history with Ctrl-N

##############################
#      Moving directory      #
##############################
setopt auto_cd  # change directory with only directory name
setopt auto_pushd  # pushd automatically
setopt pushd_ignore_dups  # remove duplicate from directory stack
setopt pushd_to_home  # pushd with no arguments == pushd $HOME
setopt pushd_silent  # no lines or chars will be printed when will execute pushd or popd

##############################
#            PATH            #
##############################
if [ -z "$PATH_IS_SET" ]; then
    case "${OSTYPE}" in
        darwin*)
            PATH=/usr/local/bin:/usr/local/sbin:$PATH
            ;;
    esac

    NEWPATH=$HOME/opt/bin
    for lang in python go node sbt scala dart erlang protobuf haskell/ghc haskell/platform; do
        if [ ! -d /opt/$lang ]; then
            continue
        fi

        find /opt/$lang -maxdepth 1 -mindepth 1 -print0| sort -r -z| while read -r -d $'\0' ver; do
            NEWPATH=$NEWPATH:$ver/bin
            case "$lang" in
                "go" )
                    if [ -z $GOROOT ] && echo $ver| grep --quiet "^/opt/$lang/[0-9]\.[0-9]$"; then
                        export GOROOT=$ver
                    fi
                    ;;
            esac
        done
    done

    export PATH=$NEWPATH:$PATH
    export PATH_IS_SET="true"
fi

##############################
#          Aliases           #
##############################
alias where="command -v"
alias j="jobs -l"
alias la="ls -a"
alias lf="ls -F"
alias ll="ls -l -h"
alias du="du -h"
alias df="df -h"
alias su="su -l"

alias -g L='| less'
alias -g H='| head'
alias -g T='| tail'
alias -g G='| grep'
alias -g S='| sed'
alias -g A='| awk'
alias -g W='| wc'

alias -s {png,gif,jpg,bmp,PNG,GIF,JPG,BMP}=eog
alias -s html=google-chrome

##############################
#            LESS            #
##############################
export LESS='-R'
export LESSCHARSET=utf-8
if which src-hilite-lesspipe.sh > /dev/null 2>&1; then
    export LESSOPEN="| $(which src-hilite-lesspipe.sh) %s"
elif [ -x /usr/share/source-highlight/src-hilite-lesspipe.sh ]; then
    export LESSOPEN="| /usr/share/source-highlight/src-hilite-lesspipe.sh %s"
elif which lesspipe > /dev/null 2>&1; then
    export LESSOPEN="| $(which lesspipe) %s"
    export LESSCLOSE="$(which lesspipe) %s %s"
fi

##############################
#      Markdown を表示       #
##############################
function markdown() {
    if whereis markdown_py > /dev/null 2>&1; then
        markdown_py $1| w3m -T text/html -dump | less
    else
        echo 'Not installed Markdown'
    fi
}

##############################
#           GOPATH           #
##############################
function gopath() {
    if [ -n "$_PATH_ORIG" ]; then
        export PATH=$_PATH_ORIG
    fi

    if [ -z $1 ]; then
        export GOPATH=`pwd`
    elif [ -d $1 ]; then
        export GOPATH=$1
    else
        return
    fi

    _PATH_ORIG=$PATH
    export PATH=$GOPATH/bin:$PATH
}

##############################
#            PECO            #
##############################
function exists { which $1 &> /dev/null }

if exists peco; then
    function peco_select_history() {
        local tac
        exists gtac && tac="gtac" || { exists tac && tac="tac" || { tac="tail -r" } }
        BUFFER=$(fc -l -n 1 | eval $tac | peco --query "$LBUFFER")
        CURSOR=$#BUFFER         # move cursor
        zle -R -c               # refresh
    }

    zle -N peco_select_history
    bindkey '^R' peco_select_history
fi

##############################
#          dh_make           #
##############################
export DEBEMAIL="kohei.yoshida@gehirn.co.jp"
export DEBFULLNAME="Kohei YOSHIDA"

##############################
#         雑多な設定         #
##############################
# setopt no_beep  # コマンド入力エラーでBeepを鳴らさない

setopt brace_ccl
setopt numeric_glob_sort
setopt path_dirs

setopt ignore_eof

setopt bsd_echo
setopt notify
setopt long_list_jobs

setopt multios
setopt short_loops
setopt always_last_prompt
setopt cdable_vars sh_word_split

REPORTTIME=3

setopt rm_star_wait

case "${OSTYPE}" in
    darwin*)
        source $HOME/.zshrc.osx
        ;;
    linux*)
        source $HOME/.zshrc.linux
        ;;
esac

# added by travis gem
if [ -f /Users/yosida95/.travis/travis.sh ]; then
    source /Users/yosida95/.travis/travis.sh
fi
