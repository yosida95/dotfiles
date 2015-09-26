# vim: set filetype=zsh :

if [ -d /opt/node ]; then
    find /opt/node -maxdepth 1 -mindepth 1 -print0| sort -r -z| while read -r -d $'\0' prefix; do
        PATH=$prefix/bin:$PATH
    done
    unset prefix
fi