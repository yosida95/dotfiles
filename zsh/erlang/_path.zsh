# vim: set filetype=zsh :

if [ -d /opt/erlang ]; then
    find /opt/erlang -maxdepth 1 -mindepth 1 -print0| sort -nz| while read -r -d $'\0' prefix; do
        PATH=$prefix/bin:$PATH
    done
    unset prefix
fi
