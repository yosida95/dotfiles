for gcloud_prefix in $HOME/.local/google-cloud-sdk /usr/share/google-cloud-sdk; do
  if [ -d $gcloud_prefix ]; then
    if [ -r "${gcloud_prefix}/path.zsh.inc" ]; then
      source "${gcloud_prefix}/path.zsh.inc";
    fi
    if [ -r "${gcloud_prefix}/completion.zsh.inc" ]; then
      source "${gcloud_prefix}/completion.zsh.inc";
    fi
    break
  fi
done
unset gcloud_prefix
