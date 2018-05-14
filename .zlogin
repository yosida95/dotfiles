if [ -z "$TMUX" ] && (($+commands[tmux])); then
    sessions=$(tmux list-session 2>/dev/null)
    echo -e "1\tCreate a new tmux session"
    echo -e "2\tAttach to an existing tmux session"
    if [ -n $sessions ]; then
        echo $sessions| sed -e $'s/^/\t/g'
    fi
    echo -e "3\tWithout tmux"

    if [ -n "$sessions" ]; then
        echo -n "Choose one (default:2): "
        read choice
        case "$choice"; in
            "1")
                exec tmux new-session
                ;;
            "3")
                ;;
            *)
                while true; do
                    echo -n "Choose a session: "
                    read choice
                    if tmux has-session -t $choice 2>/dev/null; then
                        break
                    fi
                done
                exec tmux attach-session -t $choice
                ;;
        esac
    else
        echo -n "Choose one (default:1): "
        read choice
        case "$choice"; in
            "3")
                ;;
            *)
                exec tmux new-session
                ;;
        esac
    fi
    unset choice
    unset sessions
fi
