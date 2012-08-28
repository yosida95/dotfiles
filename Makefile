current = $(shell pwd)

all: vim zsh hg git nose tmux

vim:
	ln -s -i $(current)/.vimrc ~/.vimrc
	ln -s -i $(current)/.vim ~/
	if [ ! -d ~/.vim-backup ]; then \
		mkdir ~/.vim-backup; \
	fi

zsh:
	ln -s -i $(current)/.zshrc ~/.zshrc
	ln -s -i $(current)/.zshrc.mine ~/.zshrc.mine

hg:
	ln -s -i $(current)/.hgrc ~/.hgrc
	ln -s -i $(current)/.hgignore ~/.hgignore

git:
	ln -s -i $(current)/.gitconfig ~/.gitconfig

tmux:
	ln -s -i $(current)/.tmux.conf ~/.tmux.conf

nose:
	ln -s -i $(current)/.noserc ~/.noserc
