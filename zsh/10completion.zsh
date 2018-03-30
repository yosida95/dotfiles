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

autoload -U bashcompinit && bashcompinit
BASH_COMPLETION_DIR="/etc/bash_completion.d"
for name in "hal"; do
    name="${BASH_COMPLETION_DIR}/${name}"
    if [[ -f $name && -r $name ]]; then
        . $name
    fi
done
unset name
unset BASH_COMPLETION_DIR

# vim: set filetype=zsh:
