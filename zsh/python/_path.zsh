# vim: set filetype=zsh :

if [ -d /opt/python ]; then
    find /opt/python -maxdepth 1 -mindepth 1 -print0| sort -r -z| while read -r -d $'\0' prefix; do
        PATH=$prefix/bin:$PATH
    done
    unset prefix
fi
