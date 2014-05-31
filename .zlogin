if which tmux > /dev/null 2>&1; then
    if [ -z "$TMUX" ]; then
        tmux list-session >/dev/null 2>&1| wc -l| awk '{print $0}'| read count

        if $(tmux has-session >/dev/null 2>&1); then
            echo "Which whould you like,"
            echo -e "1\tAttach current session"
            echo -e "2\tCreate new session"
            echo -e "3\tWithout tmux"
            echo -n "Choose one (default:1): "
            read choose

            case "$choose" in
                "3" )
                    ;;
                "2" )
                    exec tmux new-session
                    ;;
                * )
                    if [ $count -eq 1 ]; then
                        exec tmux attach-session
                    else
                        tmux list-session
                        echo -n "Choose one: "
                        read choose
                        exec tmux attach-session -t $choose
                    fi
                    ;;
            esac
        else
            echo "Which whould you like,"
            echo -e "1\tCreate new session"
            echo -e "2\tWithout tmux"
            echo -n "Choose one (default:1): "
            read choose

            case "$choose" in
                "2" )
                    ;;
                * )
                    exec tmux new-session
                    ;;
            esac
        fi
    fi
elif which screen > /dev/null 2>&1; then
    if [[ $TERM != "screen" ]]; then
        output=$(screen -list)
        echo -n "$output"| wc -l| read lines
        if [ "$lines" -gt 1 ]; then
            echo "Which whould you like,"
            echo -e "1\tAttach current session"
            echo -e "2\tCreate new session"
            echo -e "3\tWithout screen"
            echo -n "Choose one (default:1): "
            read choose

            case "$choose" in
                "3" )
                    ;;
                "2" )
                    exec screen
                    ;;
                * )
                    sessions=()
                    attachable=()

                    echo "Choose one: (default: 1)"
                    echo -n "$output"| head -n $(expr $lines - 1)| tail -n $(expr $lines - 2)| while read session; do
                        if echo $session| awk '{print tolower($2)}'| grep -q 'attached'; then
                            attachable+=(0)
                        else
                            attachable+=(1)
                        fi

                        sessions+=($(echo $session| awk '{print $1 }'))
                        echo -e "$#sessions[*]:\t$sessions[$#sessions[*]]"
                    done

                    read choose
                    if [ $choose -gt $#sessions[*] ] || [ $choose -lt 1 ]; then
                        choose=1
                    fi

                    if [ $attachable[$choose] -eq 1 ]; then
                        exec screen -r $sessions[$choose]
                    else
                        exec screen -x -r $sessions[$choose]
                    fi
                    ;;
            esac
        else
            echo "Which whould you like,"
            echo -e "1\tCreate new session"
            echo -e "2\tWithout screen"
            echo -n "Choose one (default:1): "
            read choose

            case "$choose" in
                "2" )
                    ;;
                * )
                    exec screen
            esac
        fi
    fi
fi
