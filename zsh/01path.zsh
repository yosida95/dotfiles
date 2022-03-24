if [ -z "$_ZSHRC_ORIG_PATH" ]; then
  export _ZSHRC_ORIG_PATH=$PATH
else
  PATH=$_ZSHRC_ORIG_PATH
fi

# deduplicate $PATH (keep the first occurrence)
typeset -U PATH path
export PATH

if [ "$(uname)" = "Darwin" ] && [ -n "$HOMEBREW_PREFIX" ]; then
  path=(
    $HOMEBREW_PREFIX/opt/coreutils/libexec/gnubin(N-/:a)
    $HOMEBREW_PREFIX/opt/gnu-sed/libexec/gnubin(N-/:a)
    $HOMEBREW_PREFIX/opt/grep/libexec/gnubin(N-/:a)
    $HOMEBREW_PREFIX/opt/openssl/bin(N-/:a)
    $path
  )
fi

runtime_versions() {
  find -L $1 -maxdepth 2 -name bin -type d -print0\
    | sort -Vrz\
    | tr '\0' ':'
}

() {
  local prefix

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
      PATH="$(runtime_versions $prefix| cut -d ':' -f 1):${PATH}"
    fi
  done

  # Emit all installed versions
  for prefix in /opt/python; do
    if [ -d "$prefix" ]; then
      PATH="$(runtime_versions $prefix)${PATH}"
    fi
  done
}

# The next line updates PATH for the Google Cloud SDK.
if [ -f "${HOME}/.local/google-cloud-sdk/path.zsh.inc" ]; then
  source "${HOME}/.local/google-cloud-sdk/path.zsh.inc";
fi

path=(
  $HOME/proj/bin(N-/:a)
  $HOME/.local/bin(N-/:a)

  /opt/circleci/bin(N-/:a)
  $HOME/.cargo/bin(N-/:a)
  $HOME/.rbenv/bin(N-/:a)
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
