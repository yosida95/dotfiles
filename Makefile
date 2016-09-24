all: dircolors vim zshconf hg git nose tmux

dircolors:
	ln -s -f ${PWD}/.dircolors ${HOME}/.dircolors

vim:
	ln -s -f ${PWD}/.vim ${HOME}/
	mkdir -p ${HOME}/.cache/dein/repos/github.com/Shougo
	if [ ! -d ${HOME}/.cache/dein/repos/github.com/Shougo/dein.vim ]; then git clone git@github.com:Shougo/dein.vim ${HOME}/.cache/dein/repos/github.com/Shougo/dein.vim; fi

zshconf: dircolors
	ln -s -f ${PWD}/.zshenv ${HOME}/.zshenv
	ln -s -f ${PWD}/.zprofile ${HOME}/.zprofile
	ln -s -f ${PWD}/.zshrc ${HOME}/.zshrc
	ln -s -f ${PWD}/.zlogin ${HOME}/.zlogin

hg:
	ln -s -f ${PWD}/.hgrc ${HOME}/.hgrc
	ln -s -f ${PWD}/.hgignore ${HOME}/.hgignore

git:
	ln -s -f ${PWD}/.gitconfig ${HOME}/.gitconfig

tmux:
	ln -s -f ${PWD}/.tmux.conf ${HOME}/.tmux.conf

screen:
	ln -s -f ${PWD}/.screenrc ${HOME}/.screenrc

nose:
	ln -s -f ${PWD}/.noserc ${HOME}/.noserc
