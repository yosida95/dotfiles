autoload -U compinit && compinit

if (($+commands[kubectl])); then
    source <(kubectl completion zsh)
fi

if (($+commands[gcloud])); then
    file="${"$(which gcloud)":h:h}/completion.zsh.inc"
    if [[ -f "$file" && -r "$file" ]]; then
        . "$file"
    elif [[ -f "/usr/share/google-cloud-sdk/completion.zsh.inc" &&
            -r "/usr/share/google-cloud-sdk/completion.zsh.inc" ]]; then
        . /usr/share/google-cloud-sdk/completion.zsh.inc
    fi
    unset file
fi

# vim: set filetype=zsh:
