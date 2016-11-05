# Path to dotfiles
DOTFILES=$HOME/proj/src/github.com/yosida95/dotfiles

# Configuration files
files=($DOTFILES/zsh/**/*.zsh)

# Set $PATH
if [ -z "$PATH_WAS_SET" ]; then
    for config in ${(M)files:#**/_path.zsh}; do
        source $config
    done
    export PATH=$HOME/.local/bin:$PATH
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

autoload -U compinit && compinit
