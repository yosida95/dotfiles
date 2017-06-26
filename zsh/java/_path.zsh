# vim: set filetype=zsh :

if [ -d /usr/lib/jvm ]; then
    find /usr/lib/jvm -maxdepth 1 -mindepth 1 -type d -print0| sort -nz| while read -r -d $'\0' prefix; do
        PATH=$prefix/bin:$PATH
        JAVA_HOME=$prefix
    done
    export JAVA_HOME
fi
