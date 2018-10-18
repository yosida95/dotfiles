all: dircolors vim zshconf hg git nose tmux

dircolors:
	ln -s -f ${PWD}/.dircolors ${HOME}/.dircolors

vim:
	ln -s -f ${PWD}/.vim ${HOME}/
	mkdir -p ${HOME}/.cache/vimbackup
	mkdir -p ${HOME}/.cache/vimswap
	mkdir -p ${HOME}/.cache/vimundo
	mkdir -p ${HOME}/.cache/dein/repos/github.com/Shougo
	if [ ! -d ${HOME}/.cache/dein/repos/github.com/Shougo/dein.vim ]; then git clone https://github.com/Shougo/dein.vim ${HOME}/.cache/dein/repos/github.com/Shougo/dein.vim; fi
	if [ ! -f ${HOME}/.local/lib/google-java-format-1.6-all-deps.jar ]; then \
		mkdir -p ${HOME}/.local/lib && \
		curl -L -o ${HOME}/.local/lib/google-java-format-1.6-all-deps.jar https://github.com/google/google-java-format/releases/download/google-java-format-1.6/google-java-format-1.6-all-deps.jar; \
	fi

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
	ln -s -f ${PWD}/.gitignore_global ${HOME}/.gitignore_global

tmux:
	ln -s -f ${PWD}/.tmux.conf ${HOME}/.tmux.conf

screen:
	ln -s -f ${PWD}/.screenrc ${HOME}/.screenrc

nose:
	ln -s -f ${PWD}/.noserc ${HOME}/.noserc


.PHONY: dircolors git hg nose screen tmux vim zshconf
