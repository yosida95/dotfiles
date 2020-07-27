#!/bin/bash
set -eu

srchilite="$(which source-highlight || true)"
lesspipe="$(which lesspipe || true)"
if [ -z "$lesspipe" ]; then
  lesspipe="$(which lesspipe.sh || true)"
fi

case "$1" in
  *.doc| \
  *.pdf| \
  *.pem|*.crt| \
  *.deb| \
  *.iso|*.raw| \
  *.tar| \
  *.bz|*.bz2| \
  *.gz|*.tgz| \
  *.lha|*.lzh| \
  *.zip|*.jar|*.war)
    exec "$lesspipe" "$1"
    ;;
  *)
    if [ -n "$srchilite" ] && file "$1"| grep -Ee '(^|[, ])text($|[, ])' > /dev/null; then
      exec "$srchilite" --failsafe --infer-lang -f esc --style-file=esc.style -i "$1"
    fi
    ;;
esac
