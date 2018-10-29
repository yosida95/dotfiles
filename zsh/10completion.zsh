autoload -U compinit && compinit

if (($+commands[kubectl])); then
  kubectl() {
    unset -f "$0"
    . <(kubectl completion zsh)
    $0 "$@"
  }
fi

if (($+commands[gcloud])); then
  for file in "${"$(which gcloud)":h:h}/completion.zsh.inc" "/usr/share/google-cloud-sdk/completion.zsh.inc"; do
    file="${"$(which gcloud)":h:h}/completion.zsh.inc"
    if [[ -f "$file" && -r "$file" ]]; then
        . "$file"
        break
    fi
  done
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
