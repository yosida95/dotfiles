export DOTFILES="${$(print -P %N):A:h}"
export LANG=en_US.UTF-8

# Prevent compinit from being called in /etc/zshrc on Ubuntu
if grep -q '^ID.*=.*ubuntu' /etc/os-release 2>/dev/null; then
  skip_global_compinit=1
fi
