# vim: set filetype=zsh :

if [ -d /opt/protobuf ]; then
    find /opt/protobuf -maxdepth 1 -mindepth 1 -print0| sort -nz| while read -r -d $'\0' prefix; do
        PATH=$prefix/bin:$PATH
    done
    unset prefix
fi
