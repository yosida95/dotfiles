if [[ `uname` == "Darwin" ]]; then
    if [ -d "/usr/local/opt/coreutils" ]; then
        PATH="/usr/local/opt/coreutils/libexec/gnubin":$PATH
    fi
fi

# vim: set filetype=zsh :
