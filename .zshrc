# Path to dotfiles
DOTFILES=$HOME/src/dotfiles

# Configuration files
files=($DOTFILES/zsh/**/*.zsh)

# Set $PATH
if [ -z "$PATH_WAS_SET" ]; then
    for config in ${(M)files:#**/_path.zsh}; do
        source $config
    done
    export PATH=$HOME/opt/bin:/usr/local/bin:$PATH
    PATH_WAS_SET=1
fi

# Apply all configrations
for config in ${files:#**/_path.zsh}; do
    source $config
done

# Load shell functions
fpath=($DOTFILES/zsh/_functions $fpath)
autoload -U $DOTFILES/zsh/_functions/*(:t)

# Clean up
unset files

# Apply OS-depend configurations
case "${OSTYPE}" in
    darwin*)
        source $HOME/.zshrc.osx
        ;;
    linux*)
        source $HOME/.zshrc.linux
        ;;
esac

autoload -U compinit && compinit
