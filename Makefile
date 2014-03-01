all: vim zsh hg git nose tmux

vim: submodule
	ln -s -f ${PWD}/.vimrc ${HOME}/.vimrc
	ln -s -f ${PWD}/.vim ${HOME}/
	if [ ! -d ${HOME}/.vim-backup ]; then \
		mkdir ${HOME}/.vim-backup; \
	fi

zsh: submodule
	ln -s -f ${PWD}/.zprofile ${HOME}/.zprofile
	ln -s -f ${PWD}/.zshrc ${HOME}/.zshrc
	ln -s -f ${PWD}/.zshrc.mine ${HOME}/.zshrc.mine
	ln -s -f ${PWD}/.zshrc.osx ${HOME}/.zshrc.osx
	ln -s -f ${PWD}/.zshrc.linux ${HOME}/.zshrc.linux
	ln -s -f ${PWD}/.zlogin ${HOME}/.zlogin

hg:
	ln -s -f ${PWD}/.hgrc ${HOME}/.hgrc
	ln -s -f ${PWD}/.hgignore ${HOME}/.hgignore

git:
	ln -s -f ${PWD}/.gitconfig ${HOME}/.gitconfig

tmux:
	ln -s -f ${PWD}/.tmux.conf ${HOME}/.tmux.conf

nose:
	ln -s -f ${PWD}/.noserc ${HOME}/.noserc

submodule:
	git submodule init
	git submodule update
