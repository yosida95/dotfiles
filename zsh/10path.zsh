path=(
  $DOTFILES/bin
  $HOME/proj/bin(N-/:a)
  $HOME/.local/bin(N-/:a)
  $HOME/.cargo/bin(N-/:a)
  $HOME/.luarocks/bin(N-/:a)
  $HOME/.rbenv/bin(N-/:a)

  /opt/circleci/bin(N-/:a)

  # Emit only the latest version
  /opt/erlang/*/bin(N/On[1])
  /opt/go/*/bin(N/On[1])
  /opt/gradle/*/bin(N/On[1])
  /opt/node/*/bin(N/On[1])
  /opt/protobuf/*/bin(N/On[1])
  /opt/scala/*/bin(N/On[1])
  /opt/sbt/*/bin(N/On[1])
  /opt/tmux/*/bin(N/On[1])
  /opt/vim/*/bin(N/On[1])

  # Emit all installed versions
  /opt/python/*/bin(N/On)

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
