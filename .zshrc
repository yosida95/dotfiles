DOTFILES=$HOME/proj/src/github.com/yosida95/dotfiles

FPATH="${DOTFILES}/zsh/_functions:/usr/share/zsh/site-functions:${FPATH}"

configs=($DOTFILES/zsh/**/*.zsh)
for config in ${(M)configs:#**/_path.zsh}; do # Only **/_path.zsh
    source $config
done
for config in ${configs:#**/_path.zsh}; do  # Expect **/_path.zsh
    source $config
done
unset configs

# Load custom shell functions
autoload -U $DOTFILES/zsh/_functions/*(:t)

if [ -z "$TMUX" ]; then
    gopath $HOME/proj
fi
