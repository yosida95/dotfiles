# vim: set filetype=zsh :

if (($+commands[peco])); then
    function peco_select_history() {
        local tac
        if (($+commands[tac])); then
            tac="tac"
        else
            # GNU coreutils not found
            tac="tail -r"
        fi

        BUFFER=$(fc -l -n 1| eval $tac| peco --query "$LBUFFER")
        CURSOR=$#BUFFER         # move cursor
        zle -R -c               # refresh
    }

    zle -N peco_select_history
    bindkey '^R' peco_select_history

    if (($+commands[ghq])); then
        function peco-src () {
        local selected_dir=$(ghq list -p | peco --query "$LBUFFER")
        if [ -n "$selected_dir" ]; then
            BUFFER="cd ${selected_dir}"
            zle accept-line
        fi
        zle clear-screen
        }
        zle -N peco-src
        bindkey '^]' peco-src
    fi
fi
