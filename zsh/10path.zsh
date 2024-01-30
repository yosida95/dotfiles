runtime_versions() {
  find -L $1 -maxdepth 2 -name bin -type d -print0\
    | sort -Vrz\
    | tr '\0' ':'
}

# Emit only the latest version
for prefix in /opt/erlang \
              /opt/go \
              /opt/gradle \
              /opt/node \
              /opt/protobuf \
              /opt/scala /opt/sbt \
              /opt/tmux \
              /opt/vim; do
  if [ -d "$prefix" ]; then
    path=($(runtime_versions $prefix| cut -d ':' -f 1) $path)
  fi
done

# Emit all installed versions
for prefix in /opt/python; do
  if [ -d "$prefix" ]; then
    PATH="$(runtime_versions $prefix)${PATH}"
  fi
done

unset prefix

if (($+commands[go])); then
  GOROOT="${${commands[go]}:h:h}"
  if [[ $GOROOT == /opt/go/* ]]; then
    export GOROOT
  else
    unset GOROOT
  fi
fi

if (($+commands[java])); then
  case "$(uname)" in
    "Darwin")
      if [ -x /usr/libexec/java_home ]; then
        export JAVA_HOME="$(/usr/libexec/java_home)"
      fi
      ;;
    *)
      export JAVA_HOME="${$(readlink -f ${commands[java]}):h:h}"
      ;;
  esac
fi

if (($+commands[luarocks])); then
  . <(luarocks path)
  path=(
    $HOME/.luarocks/bin(N-/:a)
    $path
  )
fi

path=(
  $DOTFILES/bin
  $HOME/proj/bin(N-/:a)
  $HOME/.local/bin(N-/:a)
  $HOME/.cargo/bin(N-/:a)
  $HOME/.rbenv/bin(N-/:a)
  /opt/circleci/bin(N-/:a)
  $path
)
