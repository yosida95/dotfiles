if [ -z "$TMUX" ] && (($+commands[tmux])); then
    cat << EOF
Which whould you like,
1	Create a new session
2	Attach to existing sessions
3	Without tmux
EOF
    if sessions=$(tmux list-session 2>/dev/null); then
        echo -n "Choose one (default:2): "
        read choice
        case "$choice"; in
            "1")
                exec tmux new-session
                ;;
            "3")
                ;;
            *)
                echo $sessions
                while true; do
                    echo -n "Choose one: "
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
fi
