# vim: set filetype=zsh:

if (($+commands[kubectl])); then
    source <(kubectl completion zsh)
fi
