if [ -d /opt/erlang ]; then
    find /opt/erlang -maxdepth 1 -mindepth 1 -print0| sort -nz| while read -r -d $'\0' prefix; do
        PATH=$prefix/bin:$PATH
    done
fi

if [ -d /opt/go ]; then
    find /opt/go -maxdepth 1 -mindepth 1 -print0| sort -nz| while read -r -d $'\0' prefix; do
        PATH=$prefix/bin:$PATH
        GOROOT=$prefix
    done
    export GOROOT
fi

if [ -d /usr/lib/jvm ]; then
    find /usr/lib/jvm -maxdepth 1 -mindepth 1 -type d -print0| sort -nz| while read -r -d $'\0' prefix; do
        PATH=$prefix/bin:$PATH
        JAVA_HOME=$prefix
    done
    export JAVA_HOME
fi

if [ -d /opt/node ]; then
    find /opt/node -maxdepth 1 -mindepth 1 -print0| sort -nz| while read -r -d $'\0' prefix; do
        PATH=$prefix/bin:$PATH
    done
fi

if [ -d /opt/protobuf ]; then
    find /opt/protobuf -maxdepth 1 -mindepth 1 -print0| sort -nz| while read -r -d $'\0' prefix; do
        PATH=$prefix/bin:$PATH
    done
fi

if [ -d /opt/python ]; then
    find /opt/python -maxdepth 1 -mindepth 1 -print0| sort -nz| while read -r -d $'\0' prefix; do
        PATH=$prefix/bin:$PATH
    done
fi

if [ -d  $HOME/.cargo/bin ]; then
    PATH=$HOME/.cargo/bin:$PATH
fi

unset prefix

# vim: set filetype=zsh :
