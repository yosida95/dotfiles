# vim: set filetype=zsh :

if [ -d /opt/go ]; then
    find /opt/go -maxdepth 1 -mindepth 1 -print0| sort -nz| while read -r -d $'\0' prefix; do
        PATH=$prefix/bin:$PATH
        GOROOT=$prefix
    done
    export GOROOT
fi
