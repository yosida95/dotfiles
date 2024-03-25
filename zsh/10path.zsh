path=(
  $DOTFILES/bin
  $HOME/proj/bin(N-/:a)
  $HOME/.local/bin(N-/:a)
  $HOME/.cargo/bin(N-/:a)
  $HOME/.luarocks/bin(N-/:a)
  $HOME/.rbenv/bin(N-/:a)

  /opt/circleci/bin(N-/:a)

  # Emit only the latest version
  /opt/erlang/*/bin(N/Onn[1]:a)
  /opt/go/*/bin(N/Onn[1]:a)
  /opt/gradle/*/bin(N/Onn[1]:a)
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

if (($+commands[luarocks])); then
  . <(luarocks path)
fi
