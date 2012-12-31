if [ -z "$TMUX" ]; then
    if $(tmux has-session); then
        exec tmux attach
    else
        exec tmux new-session
    fi
fi
