# vim: set filetype=zsh :

if [[ `uname` == "Darwin" ]] && [ -d "/usr/local/opt/coreutils" ]; then
    PATH="/usr/local/opt/coreutils/libexec/gnubin":$PATH
fi
