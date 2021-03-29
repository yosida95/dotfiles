autoload -Uz +X compinit && compinit

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
