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

for prefix in /usr/lib/jvm /opt/erlang /opt/go /opt/gradle /opt/node /opt/protobuf /opt/python /opt/sbt /opt/scala /opt/vim; do
    if [ -d "$prefix" ]; then
        PATH="$(find -L $prefix -maxdepth 2 -name bin -type d -print0| sort -Vrz| tr '\0' ':')${PATH}"
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
unset prefix

if [ -d "$HOME/.rbenv" ]; then
    PATH=$HOME/.rbenv/bin:$PATH
    eval "$(rbenv init -)"
fi

if [ -d "$HOME/.cargo/bin" ]; then
    PATH=$HOME/.cargo/bin:$PATH
fi

# The next line updates PATH for the Google Cloud SDK.
if [ -f "${HOME}/.local/google-cloud-sdk/path.zsh.inc" ]; then
    source "${HOME}/.local/google-cloud-sdk/path.zsh.inc";
fi

if [ -d "$HOME/.local/bin" ]; then
    PATH=$HOME/.local/bin:$PATH
fi

export PATH
