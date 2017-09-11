if [[ `uname` == "Darwin" ]]; then
    if [ -d "/usr/local/opt/coreutils" ]; then
        PATH="/usr/local/opt/coreutils/libexec/gnubin":$PATH
    fi

    # The next line updates PATH for the Google Cloud SDK.
    if [ -f '/Users/yosida95/.local/google-cloud-sdk/path.zsh.inc' ]; then
        source '/Users/yosida95/.local/google-cloud-sdk/path.zsh.inc';
    fi
fi


# vim: set filetype=zsh :
