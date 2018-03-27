case "$(uname)" in
    "Darwin")
        coreutils="/usr/local/opt/coreutils/libexec/gnubin"
        if [ -d "$coreutils" ]; then
            PATH="${coreutils}:${PATH}"
        fi
        unset coreutils
        ;;
esac

for prefix in /opt/erlang /opt/gradle /opt/node /opt/protobuf /opt/python /opt/vim; do
    if [ -d "$prefix" ]; then
        PATH="$(find -L $prefix -maxdepth 2 -name bin -type d -print0| sort -Vrz| tr '\0' ':')${PATH}"
    fi
done

if [ -d /opt/go ]; then
    find /opt/go -maxdepth 1 -mindepth 1 -print0| sort -Vz| while read -r -d $'\0' prefix; do
        PATH=$prefix/bin:$PATH
        GOROOT=$prefix
    done
    export GOROOT
fi

if [ -d /usr/lib/jvm ]; then
    find /usr/lib/jvm -maxdepth 2 -mindepth 2 -name bin -type d -print0| sort -z| while read -r -d $'\0' prefix; do
        PATH=$prefix:$PATH
        JAVA_HOME=${prefix%/bin}
    done
    export JAVA_HOME
fi

if [ -d  $HOME/.cargo/bin ]; then
    PATH=$HOME/.cargo/bin:$PATH
fi

# The next line updates PATH for the Google Cloud SDK.
if [ -f "${HOME}/.local/google-cloud-sdk/path.zsh.inc" ]; then
    source "${HOME}/.local/google-cloud-sdk/path.zsh.inc";
fi

unset prefix

export PATH=$HOME/.local/bin:$PATH

# vim: set filetype=zsh :
