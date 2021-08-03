bindkey -d
bindkey -v  # use vi like keybind

autoload -U history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^P" history-beginning-search-backward-end  # select previous history with Ctrl-P
bindkey "^N" history-beginning-search-forward-end  # select next history with Ctrl-N
