function waitEnter() {
    if [ -n "$SSH_CONNECTION" ]; then
        echo 'Press <ENTER> to continue.'
        read
    fi
    return 0
}

if which tmux > /dev/null 2>&1; then
    if [ -z "$TMUX" ]; then
        tmux list-session >/dev/null 2>&1| wc -l| awk '{print $0}'| read count

        if $(tmux has-session >/dev/null 2>&1); then
            echo "Which whould you like,"
            echo -e "1\tAttach current session"
            echo -e "2\tCreate new session"
            echo -n "Choose one (default:1): "
            read choose

            if [ $choose -eq 2 ]; then
                exec tmux new-session
            else
                if [ $count -eq 1 ]; then
                    exec tmux attach-session
                else
                    tmux list-session
                    read choose
                    exec tmux attach-session -t $choose
                fi
            fi
        else
            echo 'Press <ENTER> to continue.'
            read
            exec tmux new-session
        fi
    fi
elif which screen > /dev/null 2>&1; then
    waitEnter

    exec screen -R
fi
