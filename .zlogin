if [ -z "$TMUX" ]; then
    if [ -n "$SSH_CONNECTION" ]; then
        echo 'Press <ENTER> to continue.'
        read
    fi

    if $(tmux has-session); then
        exec tmux attach
    else
        exec tmux new-session
    fi
fi
