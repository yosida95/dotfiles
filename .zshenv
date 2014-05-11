export LANG=en_US.UTF-8
export LANGUAGE=$LANG
export LC_ALL=$LANG

if [ -z "$PATH_IS_SET" ]; then
    case "${OSTYPE}" in
        darwin*)
            PATH=/usr/local/bin:/usr/local/sbin:$PATH
            ;;
    esac

    NEWPATH=$HOME/opt/bin
    for lang in python go node erlang protobuf haskell/ghc haskell/platform; do
        if [ ! -d /opt/$lang ]; then
            continue
        fi

        find /opt/$lang -maxdepth 1 -mindepth 1 -print0| sort -r -z| while read -r -d $'\0' ver; do
            NEWPATH=$NEWPATH:$ver/bin
            case "$lang" in
                "go" )
                    if [ -z $GOROOT ] && echo $ver| grep --quiet "^/opt/$lang/[0-9]\.[0-9]$"; then
                        export GOROOT=$ver
                    fi
                    ;;
            esac
        done
    done
    export PATH=$NEWPATH:$PATH

    export PATH_IS_SET="true"
fi

# EDITOR
export EDITOR='vim'

# Mercurial
export HGENCODING='utf-8'
