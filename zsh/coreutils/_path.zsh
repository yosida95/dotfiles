# vim: set filetype=zsh :

if (($+commands[brew])) && [ -d "$(brew --prefix coreutils)" ]; then
    PATH=$(brew --prefix coreutils)/libexec/gnubin:$PATH
fi
