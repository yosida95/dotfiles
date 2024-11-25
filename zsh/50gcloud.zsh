case "${commands[gcloud]}" in
  $HOME/.local/google-cloud-sdk/*)
    . "$HOME/.local/google-cloud-sdk/completion.zsh.inc"
    if [ -x "$HOME/.venvs/gcloud/bin/python3" ]; then
      export CLOUDSDK_PYTHON="$HOME/.venvs/gcloud/bin/python3"
      export CLOUDSDK_PYTHON_SITEPACKAGES=1
    fi
    ;;
  /usr/bin/*)
    . "/usr/share/google-cloud-sdk/completion.zsh.inc"
    ;;
esac
