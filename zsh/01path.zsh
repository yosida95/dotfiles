if [ -z "$_ZSHRC_ORIG_PATH" ]; then
  export _ZSHRC_ORIG_PATH=$PATH
else
  PATH=$_ZSHRC_ORIG_PATH
fi

case "$(uname)" in
  "Darwin")
    for prefix in /usr/local/opt/coreutils/libexec/gnubin \
                  /usr/local/opt/gnu-sed/libexec/gnubin \
                  /usr/local/opt/grep/libexec/gnubin; do
      if [ -d "$prefix" ]; then
        PATH="${prefix}:${PATH}"
      fi
    done
    ;;
esac

runtime_versions() { find -L $1 -maxdepth 2 -name bin -type d -print0| sort -Vrz| tr '\0' ':' }

# Emit only the latest version
for prefix in /opt/erlang \
              /opt/go \
              /opt/gradle \
              /opt/node \
              /opt/protobuf \
              /opt/scala /opt/sbt \
              /opt/tmux /opt/vim; do
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

# Emit "$prefix/bin"
for prefix in /opt/circleci $HOME/.cargo $HOME/.local $HOME/.rbenv; do
  if [ -d "$prefix/bin" ]; then
    PATH=$prefix/bin:$PATH
  fi
done

unset prefix
export PATH

# The next line updates PATH for the Google Cloud SDK.
if [ -f "${HOME}/.local/google-cloud-sdk/path.zsh.inc" ]; then
  source "${HOME}/.local/google-cloud-sdk/path.zsh.inc";
fi

if (($+commands[go])); then
  export GOROOT="${${commands[go]}:h:h}"
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

if (($+commands[rbenv])); then
  eval "$(rbenv init -)"
fi
