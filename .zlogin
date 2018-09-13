if [ -z "$TMUX" ] && (($+commands[tmux])); then
    sessions=$(tmux list-session 2>/dev/null)
    if [ -n $sessions ]; then
        echo $sessions| sed -e $'s/^/\t/g'
    fi
    unset sessions

    echo -n "> "
    read choice
    if tmux has-session -t $choice 2>/dev/null; then
        exec tmux attach-session -t $choice
    elif [ -n "$choice" ]; then
      exec tmux new-session -s $choice
    fi
    unset choice
fi
