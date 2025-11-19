if [ "$(uname)" = "Darwin" ]; then
  for HOMEBREW_PREFIX in /opt/homebrew /usr/local; do
    if [ -x "$HOMEBREW_PREFIX/bin/brew" ]; then
      . <($HOMEBREW_PREFIX/bin/brew shellenv)
      break
    fi
  done

  if [ -n "$HOMEBREW_PREFIX" ]; then
    path=(
      $HOMEBREW_PREFIX/opt/coreutils/libexec/gnubin(N-/:a)
      $HOMEBREW_PREFIX/opt/gnu-getopt/bin(N-/:a)
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
  fi
fi

path=(
  $DOTFILES/bin
  $HOME/proj/bin(N-/:a)
  $HOME/.local/bin(N-/:a)
  $HOME/.cache/rebar3/bin(N-/:a)
  $HOME/.cargo/bin(N-/:a)
  $HOME/.luarocks/bin(N-/:a)
  $HOME/.rbenv/bin(N-/:a)

  $HOME/.atuin/bin(N-/:a)
  $HOME/.local/google-cloud-sdk/bin(N-/:a)
  /opt/circleci/bin(N-/:a)

  # Emit only the latest version
  /opt/erlang/*/bin(N/Onn[1]:a)
  /opt/go/*/bin(N/Onn[1]:a)
  /opt/gradle/*/bin(N/Onn[1]:a)
  /opt/jsonnet/*/bin(N/Onn[1]:a)
  /opt/node/*/bin(N/Onn[1]:a)
  /opt/protobuf/*/bin(N/Onn[1]:a)
  /opt/scala/*/bin(N/Onn[1]:a)
  /opt/sbt/*/bin(N/Onn[1]:a)
  /opt/tmux/*/bin(N/Onn[1]:a)
  /opt/vim/*/bin(N/Onn[1]:a)

  # Emit all installed versions
  /opt/python/*/bin(N/Onn:a)

  $path
)

if (($+commands[go])); then
  GOROOT="${${commands[go]}:h:h}"
  if [[ $GOROOT == /opt/go/* ]]; then
    export GOROOT
  else
    unset GOROOT
  fi
  export GOPATH=$HOME/proj
  export GOBIN=$GOPATH/bin
  export GOPRIVATE=github.com/yosida95,github.com/GehirnInc
fi

if (($+commands[java])); then
  if [[ $(uname) == "Darwin" ]]; then
    if [ -x /usr/libexec/java_home ]; then
      export JAVA_HOME="$(/usr/libexec/java_home)"
    fi
  else
    export JAVA_HOME="${commands[java]:A:h:h}"
  fi
fi
