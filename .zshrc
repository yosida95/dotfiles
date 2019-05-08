DOTFILES="${$(print -P %N):A:h}"
FPATH="${DOTFILES}/zsh/completion:${DOTFILES}/zsh/_functions:/usr/share/zsh/site-functions:${FPATH}"

for config in $DOTFILES/zsh/**/*.zsh; do
    source $config
done
unset config

# Load custom shell functions
autoload -U $DOTFILES/zsh/_functions/*(:t)

gopath $HOME/proj
