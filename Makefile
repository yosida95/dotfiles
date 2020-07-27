LOCAL_BIN := ${HOME}/.local/bin
XDG_CONFIG_HOME ?= ${HOME}/.config

.PHONY: all
all: | ${HOME}/.dircolors \
		${XDG_CONFIG_HOME}/git/config \
		${XDG_CONFIG_HOME}/git/ignore \
		${HOME}/.hgrc \
		${HOME}/.tmux.conf \
		${HOME}/.vim \
		${HOME}/.zshenv \
		${HOME}/.zshrc

${HOME}/.dircolors:
	ln -sf ${PWD}/.dircolors ${HOME}/

${XDG_CONFIG_HOME}/git:
	mkdir -p ${XDG_CONFIG_HOME}/git

${XDG_CONFIG_HOME}/git/config: | ${XDG_CONFIG_HOME}/git
	ln -s ${PWD}/git/config ${XDG_CONFIG_HOME}/git/config

${XDG_CONFIG_HOME}/git/ignore: | ${XDG_CONFIG_HOME}/git
	ln -s ${PWD}/git/ignore ${XDG_CONFIG_HOME}/git/ignore

${HOME}/.hgrc: | ${HOME}/.hgignore
	ln -sf ${PWD}/.hgrc ${HOME}/

${HOME}/.hgignore:
	ln -sf ${PWD}/.hgignore ${HOME}/

${HOME}/.tmux.conf:
	ln -sf ${PWD}/.tmux.conf ${HOME}/

${HOME}/.vim: | \
		${HOME}/.cache/vimbackup \
		${HOME}/.cache/vimswap \
		${HOME}/.cache/vimundo \
		${LOCAL_BIN}/checkstyle \
		${LOCAL_BIN}/google-java-format
	ln -sf ${PWD}/.vim ${HOME}/

${HOME}/.cache/vimbackup:
	mkdir -p ${HOME}/.cache/vimbackup

${HOME}/.cache/vimswap:
	mkdir -p ${HOME}/.cache/vimswap

${HOME}/.cache/vimundo:
	mkdir -p ${HOME}/.cache/vimundo

${HOME}/.local/lib/${GOOGLE_JAVA_FORMAT}-all-deps.jar:
	mkdir -p ${HOME}/.local/lib
	curl -Lf -o $@ https://github.com/google/google-java-format/releases/download/${GOOGLE_JAVA_FORMAT}/${GOOGLE_JAVA_FORMAT}-all-deps.jar

${HOME}/.zshenv:
	ln -sf ${PWD}/.zshenv ${HOME}/

${HOME}/.zshrc:
	ln -sf ${PWD}/.zshrc ${HOME}/

${LOCAL_BIN}/checkstyle:
	mkdir -p ${LOCAL_BIN}
	ln -sf ${PWD}/contrib/checkstyle ${LOCAL_BIN}/checkstyle

${LOCAL_BIN}/google-java-format:
	mkdir -p ${LOCAL_BIN}
	ln -sf ${PWD}/contrib/google-java-format ${LOCAL_BIN}/google-java-format
