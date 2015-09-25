# vim: set filetype=zsh :

if which peco &>/dev/null; then
    function peco_select_history() {
        BUFFER=$(fc -l -n 1| tail -r| peco --query "$LBUFFER")
        CURSOR=$#BUFFER         # move cursor
        zle -R -c               # refresh
    }

    zle -N peco_select_history
    bindkey '^R' peco_select_history
fi
