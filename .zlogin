function waitEnter() {
    if [ -n "$SSH_CONNECTION" ]; then
        echo 'Press <ENTER> to continue.'
        read
    fi
    return 0
}

if which tmux > /dev/null 2>&1; then
    if [ -z "$TMUX" ]; then
        waitEnter

        if $(tmux has-session); then
            exec tmux attach
        else
            exec tmux new-session
        fi
    fi
elif which screen > /dev/null 2>&1; then
    waitEnter

    exec screen -R
fi
