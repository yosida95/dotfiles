autoload -Uz +X compinit && compinit

bashcompdef=/usr/share/bash-completion/completions
if [ -d "$bashcompdef" ] &&  [ -f "$bashcompdef/git" ]; then
  autoload -Uz +X bashcompinit && bashcompinit
  . "$bashcompdef/git" >/dev/null 2>&1
fi

if (($+commands[kubectl])); then
  kubectl() {
    unset -f "$0"
    . <(kubectl completion zsh)
    $0 "$@"
  }
fi

if (($+commands[gcloud])); then
  for gcloudcompdef in "${${commands[gcloud]}:h:h}/completion.zsh.inc" \
                       "/usr/share/google-cloud-sdk/completion.zsh.inc"; do
    if [[ -f "$gcloudcompdef" && -r "$gcloudcompdef" ]]; then
      gcloud() {
        unset -f "$0"
        . "$gcloudcompdef"
        $0 "$@"
      }
      break
    fi
  done
fi

if (($+commands[helm])); then
  helm() {
    unset -f "$0"
    . <(helm completion zsh)
    $0 "$@"
  }
fi

if (($+commands[helm3])); then
  helm3() {
    unset -f "$0"
    . <(helm3 completion zsh)
    $0 "$@"
  }
fi
