GOOGLE_JAVA_FORMAT := google-java-format-1.7

.PHONY: all

all: | ${HOME}/.dircolors \
		${HOME}/.gitconfig \
		${HOME}/.hgrc \
		${HOME}/.lessfilter \
		${HOME}/.tmux.conf \
		${HOME}/.vim \
		${HOME}/.zshenv \
		${HOME}/.zshrc \
		${HOME}/.zlogin

${HOME}/.dircolors:
	ln -sf ${PWD}/.dircolors ${HOME}/

${HOME}/.gitconfig: | ${PWD}/.gitignore_global
	ln -sf ${PWD}/.gitconfig ${HOME}/

${HOME}/.gitignore_global:
	ln -sf ${PWD}/.gitignore_global ${HOME}/

${HOME}/.hgrc: | ${HOME}/.hgignore
	ln -sf ${PWD}/.hgrc ${HOME}/

${HOME}/.lessfilter:
	ln -sf ${PWD}/.lessfilter ${HOME}/

${HOME}/.hgignore:
	ln -sf ${PWD}/.hgignore ${HOME}/

${HOME}/.tmux.conf:
	ln -sf ${PWD}/.tmux.conf ${HOME}/

${HOME}/.vim: | \
		${HOME}/.cache/vimbackup \
		${HOME}/.cache/vimswap \
		${HOME}/.cache/vimundo \
		${HOME}/.cache/dein/repos/github.com/Shougo/dein.vim \
		${HOME}/.local/lib/${GOOGLE_JAVA_FORMAT}-all-deps.jar
	ln -sf ${PWD}/.vim ${HOME}/

${HOME}/.cache/vimbackup:
	mkdir -p ${HOME}/.cache/vimbackup

${HOME}/.cache/vimswap:
	mkdir -p ${HOME}/.cache/vimswap

${HOME}/.cache/vimundo:
	mkdir -p ${HOME}/.cache/vimundo

${HOME}/.cache/dein/repos/github.com/Shougo/dein.vim:
	mkdir -p ${HOME}/.cache/dein/repos/github.com/Shougo
	git clone https://github.com/Shougo/dein.vim.git $@

${HOME}/.local/lib/${GOOGLE_JAVA_FORMAT}-all-deps.jar:
	mkdir -p ${HOME}/.local/lib
	curl -Lf -o $@ https://github.com/google/google-java-format/releases/download/${GOOGLE_JAVA_FORMAT}/${GOOGLE_JAVA_FORMAT}-all-deps.jar

${HOME}/.zshenv:
	ln -sf ${PWD}/.zshenv ${HOME}/

${HOME}/.zshrc:
	ln -sf ${PWD}/.zshrc ${HOME}/

${HOME}/.zlogin:
	ln -sf ${PWD}/.zlogin ${HOME}/
