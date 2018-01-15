autoload -U compinit && compinit

if (($+commands[kubectl])); then
    source <(kubectl completion zsh)
fi

if (($+commands[gcloud])); then
    file="${"$(which gcloud)":h:h}/completion.zsh.inc"
    if [ -f "$file" ]; then
        source "$file"
    fi
    unset file
fi

# vim: set filetype=zsh:
