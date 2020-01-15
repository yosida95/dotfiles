if [ -z "$_ZSHRC_ORIG_PATH" ]; then
    export _ZSHRC_ORIG_PATH=$PATH
else
    PATH=$_ZSHRC_ORIG_PATH
fi

case "$(uname)" in
    "Darwin")
        coreutils="/usr/local/opt/coreutils/libexec/gnubin"
        if [ -d "$coreutils" ]; then
            PATH="${coreutils}:${PATH}"
        fi
        unset coreutils
        ;;
esac

versions() { find -L $1 -maxdepth 2 -name bin -type d -print0| sort -Vrz }

# Emit only the latest version
for prefix in /opt/tmux /opt/vim; do
    if [ -d "$prefix" ]; then
        PATH="$(versions $prefix| cut -d '' -f 1):${PATH}"
    fi
done

# Emit all installed versions
for prefix in /usr/lib/jvm /opt/gradle \
              /opt/erlang \
              /opt/go \
              /opt/node \
              /opt/protobuf \
              /opt/python \
              /opt/scala /opt/sbt; do
    if [ -d "$prefix" ]; then
        PATH="$(versions $prefix| tr '\0' ':')${PATH}"

        case "$prefix" in
            "/usr/lib/jvm")
                export JAVA_HOME="${PATH%%/bin:*}"
                ;;
            "/opt/go")
                export GOROOT="${PATH%%/bin:*}"
                ;;
        esac
    fi
done

# Emit "$prefix/bin"
for prefix in $HOME/.cargo $HOME/.local $HOME/.rbenv; do
    if [ -d "$prefix/bin" ]; then
        PATH=$prefix/bin:$PATH

        case "$prefix" in
            "$HOME/.rbenv")
                eval "$(rbenv init -)"
                ;;
        esac
    fi
done

# The next line updates PATH for the Google Cloud SDK.
if [ -f "${HOME}/.local/google-cloud-sdk/path.zsh.inc" ]; then
    source "${HOME}/.local/google-cloud-sdk/path.zsh.inc";
fi


unset prefix
unfunction versions
export PATH
