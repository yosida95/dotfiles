if [ "$(uname)" != "Darwin" ]; then
  return
fi

for HOMEBREW_PREFIX in /opt/homebrew /usr/local; do
  if [ -x "$HOMEBREW_PREFIX/bin/brew" ]; then
    . <($HOMEBREW_PREFIX/bin/brew shellenv)
    break
  fi
done

path=(
  $HOMEBREW_PREFIX/opt/coreutils/libexec/gnubin(N-/:a)
  $HOMEBREW_PREFIX/opt/gnu-sed/libexec/gnubin(N-/:a)
  $HOMEBREW_PREFIX/opt/grep/libexec/gnubin(N-/:a)
  $HOMEBREW_PREFIX/opt/openssl/bin(N-/:a)
  $HOMEBREW_PREFIX/opt/openssl@1.1/bin(N-/:a)
  $path
)

fpath=(
  $HOMEBREW_PREFIX/share/zsh/site-functions(N-/:a)
  $fpath
)
