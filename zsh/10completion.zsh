autoload -Uz +X compinit && compinit

bashcompdef=/usr/share/bash-completion/completions
if [ -r "$bashcompdef/git" ]; then
  autoload -Uz +X bashcompinit && bashcompinit
  . "$bashcompdef/git" >/dev/null 2>&1
fi

if (($+commands[gcloud])); then
  () {
    local gcloudcompdef
    for gcloudcompdef in "${${commands[gcloud]}:h:h}/completion.zsh.inc" \
                        "/usr/share/google-cloud-sdk/completion.zsh.inc"; do
      if [ -r "$gcloudcompdef" ]; then
        . "$gcloudcompdef"
        break
      fi
    done
  }
fi
