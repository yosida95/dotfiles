# vim: set filetype=zsh :

##############################
# Changing Directories
##############################
setopt AUTO_CD
setopt AUTO_PUSHD
setopt CHASE_DOTS
setopt PUSHD_IGNORE_DUPS
setopt PUSHD_SILENT
setopt PUSHD_TO_HOME

##############################
# Completion
##############################
setopt ALWAYS_LAST_PROMPT
setopt AUTO_MENU
setopt AUTO_PARAM_KEYS
setopt AUTO_PARAM_SLASH
setopt AUTO_REMOVE_SLASH
setopt COMPLETE_IN_WORD
unsetopt LIST_BEEP
setopt LIST_PACKED
setopt LIST_TYPES

zmodload zsh/complist

# Colored completion
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*:*:*:*:*' menu select

# Smart case matching
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'

# Process completion
zstyle ':completion:*:*:*:*:processes' command 'ps -u $USER -o pid,user,args'
zstyle ':completion:*:*:*:*:processes' list-colors '=(#b) #([0-9]#) ([0-9a-z-]#)*=01;34=0=01'

# Cache completion candidates
zstyle ':completion::complete:*' use-cache on

##############################
# Expansion and Globbing
##############################
setopt EXTENDED_GLOB
setopt MARK_DIRS
setopt NUMERIC_GLOB_SORT

##############################
# History
##############################
HISTFILE=$HOME/.zsh_history  # file for saving history
SAVEHIST=10000  # count of history saved on HISTFILE
HISTSIZE=10000  # count of history saved on memory

unsetopt APPEND_HISTORY
setopt EXTENDED_HISTORY
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_NO_STORE
setopt HIST_REDUCE_BLANKS
setopt HIST_SAVE_NO_DUPS
setopt HIST_VERIFY
setopt INC_APPEND_HISTORY
setopt SHARE_HISTORY

autoload -U history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^P" history-beginning-search-backward-end  # select previous history with Ctrl-P
bindkey "^N" history-beginning-search-forward-end  # select next history with Ctrl-N

##############################
# Input/Output
##############################
setopt CORRECT
unsetopt FLOW_CONTROL
setopt IGNORE_EOF
setopt INTERACTIVE_COMMENTS
setopt PRINT_EIGHT_BIT
setopt RM_STAR_WAIT

autoload -Uz url-quote-magic
zle -N self-insert url-quote-magic

REPORTTIME=3

##############################
# Job Control
##############################
setopt LONG_LIST_JOBS
setopt NOTIFY
