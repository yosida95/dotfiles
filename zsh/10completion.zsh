autoload -U compinit && compinit

if (($+commands[kubectl])); then
  kubectl() {
    unset -f "$0"
    . <(kubectl completion zsh)
    $0 "$@"
  }
fi

if (($+commands[gcloud])); then
  for gcloudcompdef in "${"$(which gcloud)":h:h}/completion.zsh.inc" "/usr/share/google-cloud-sdk/completion.zsh.inc"; do
    file="${"$(which gcloud)":h:h}/completion.zsh.inc"
    if [[ -f "$file" && -r "$file" ]]; then
      gcloud() {
        unset -f "$0"
        . "$gcloudcompdef"
        $0 "$@"
      }
      break
    fi
  done
fi

# vim: set filetype=zsh:
