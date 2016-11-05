#!/bin/bash

source_tmuxconf () {
    confdir="${0%/*}"
    tmux_version=`tmux -V| cut -d' ' -f2`

    if [[ `echo "${tmux_version} >= 1.9"| bc` -eq 1 ]]; then
        tmux source-file "$confdir/tmux_19_later.conf"
    else
        tmux source-file "$confdir/tmux_18_earlier.conf"
    fi
    return
}
source_tmuxconf
