LOCAL_BIN := ${HOME}/.local/bin
XDG_CONFIG_HOME ?= ${HOME}/.config

GIT_VERSION := v$(shell git --version| cut -d ' ' -f 3)
GIT_COMP_DIR := zsh/completion/git/${GIT_VERSION}

GHQ_VERSION := v$(shell ghq --version| cut -d ' ' -f 3)
GHQ_COMP_DIR := zsh/completion/ghq/${GHQ_VERSION}

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

${HOME}/.zshrc: | ${GIT_COMP_DIR}/git-completion.zsh ${GHQ_COMP_DIR}/_ghq
	ln -sf ${PWD}/.zshrc ${HOME}/

${GIT_COMP_DIR}:
	mkdir -p ${GIT_COMP_DIR}

${GIT_COMP_DIR}/git-completion.zsh: | ${GIT_COMP_DIR} ${GIT_COMP_DIR}/git-completion.bash
	curl -L \
		-o ${GIT_COMP_DIR}/git-completion.zsh \
		https://raw.githubusercontent.com/git/git/${GIT_VERSION}/contrib/completion/git-completion.zsh
	ln -sf git/${GIT_VERSION}/git-completion.zsh zsh/completion/_git

${GIT_COMP_DIR}/git-completion.bash: | ${GIT_COMP_DIR}
	curl -L \
		-o ${GIT_COMP_DIR}/git-completion.bash \
		https://raw.githubusercontent.com/git/git/${GIT_VERSION}/contrib/completion/git-completion.bash

${GHQ_COMP_DIR}:
	mkdir -p ${GHQ_COMP_DIR}

${GHQ_COMP_DIR}/_ghq: | ${GHQ_COMP_DIR}
	curl -L \
		-o ${GHQ_COMP_DIR}/_ghq \
		https://raw.githubusercontent.com/x-motemen/ghq/${GHQ_VERSION}/misc/zsh/_ghq
	ln -sf ghq/${GHQ_VERSION}/_ghq zsh/completion/_ghq

${LOCAL_BIN}/checkstyle:
	mkdir -p ${LOCAL_BIN}
	ln -sf ${PWD}/contrib/checkstyle ${LOCAL_BIN}/checkstyle

${LOCAL_BIN}/google-java-format:
	mkdir -p ${LOCAL_BIN}
	ln -sf ${PWD}/contrib/google-java-format ${LOCAL_BIN}/google-java-format
