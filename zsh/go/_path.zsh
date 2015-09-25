# vim: set filetype=zsh :

if [ -d /opt/go ]; then
    find /opt/go -maxdepth 1 -mindepth 1 -print0| sort -r -z| while read -r -d $'\0' prefix; do
        PATH=$prefix/bin:$PATH
        if [ -z "$GOROOT" ]; then
            export GOROOT=$prefix
        fi
    done
    unset prefix
fi
