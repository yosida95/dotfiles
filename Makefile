LOCAL_BIN := ${HOME}/.local/bin
XDG_CONFIG_HOME ?= ${HOME}/.config

ZSH_COMP_SCRIPT :=

GIT_VERSION := v$(shell git --version 2> /dev/null| cut -d ' ' -f 3)
GIT_COMP_DIR := zsh/completion/git/${GIT_VERSION}
ifneq (${GIT_VERSION},v)
ZSH_COMP_SCRIPT := ${ZSH_COMP_SCRIPT} ${GIT_COMP_DIR}/git-completion.zsh
endif

GHQ_VERSION := v$(shell ghq --version 2> /dev/null| cut -d ' ' -f 3)
GHQ_COMP_DIR := zsh/completion/ghq/${GHQ_VERSION}
ifneq (${GHQ_VERSION},v)
ZSH_COMP_SCRIPT := ${ZSH_COMP_SCRIPT} ${GHQ_COMP_DIR}/_ghq
endif

KUBECTL_VERSION := $(shell kubectl version --client --output json 2> /dev/null| jq -r .clientVersion.gitVersion)
KUBECTL_COMP_DIR := zsh/completion/kubectl/${KUBECTL_VERSION}
ifneq (${KUBECTL_VERSION},)
ZSH_COMP_SCRIPT := ${ZSH_COMP_SCRIPT} ${KUBECTL_COMP_DIR}/_kubectl
endif

.PHONY: all
all: | ${HOME}/.dircolors \
		${XDG_CONFIG_HOME}/git/config \
		${XDG_CONFIG_HOME}/git/config.gehirninc \
		${XDG_CONFIG_HOME}/git/ignore \
		${XDG_CONFIG_HOME}/kitty/kitty.conf \
		${HOME}/.hgrc \
		${HOME}/.tmux.conf \
		${HOME}/.vim \
		${HOME}/.zshenv \
		${HOME}/.zshrc

${HOME}/.dircolors:
	ln -sr .dircolors $@

${XDG_CONFIG_HOME}/git/config:
	mkdir -p $(@D)
	ln -sr git/config $@

${XDG_CONFIG_HOME}/git/config.gehirninc:
	mkdir -p $(@D)
	ln -sr git/config.gehirninc $@

${XDG_CONFIG_HOME}/git/ignore:
	mkdir -p $(@D)
	ln -sr git/ignore $@

${XDG_CONFIG_HOME}/kitty:
	mkdir -p ${XDG_CONFIG_HOME}/kitty

${XDG_CONFIG_HOME}/kitty/kitty.conf: | ${XDG_CONFIG_HOME}/kitty
	ln -sr kitty.conf $@

${HOME}/.hgrc: | ${HOME}/.hgignore
	ln -sr .hgrc $@

${HOME}/.hgignore:
	ln -sr .hgignore $@

${HOME}/.tmux.conf:
	ln -sr .tmux.conf $@

${HOME}/.vim: | \
		${HOME}/.cache/vimbackup \
		${HOME}/.cache/vimswap \
		${HOME}/.cache/vimundo \
		${LOCAL_BIN}/checkstyle \
		${LOCAL_BIN}/google-java-format \
		${HOME}/.local/share/vim-lsp-settings/settings.json
	ln -sr .vim $@

${HOME}/.cache/vimbackup:
	mkdir -p $@

${HOME}/.cache/vimswap:
	mkdir -p $@

${HOME}/.cache/vimundo:
	mkdir -p $@

${HOME}/.local/share/vim-lsp-settings/settings.json:
	mkdir -p $(@D)
	ln -srf ./.vim/vim-lsp-settings.json $@

${HOME}/.zshenv:
	ln -sr ./.zshenv $@

${HOME}/.zshrc: | ${ZSH_COMP_SCRIPT}
	ln -sr ./.zshrc $@

${GIT_COMP_DIR}/git-completion.zsh: ${GIT_COMP_DIR}/git-completion.bash
	mkdir -p $(@D)
	curl -L \
		-o $@ \
		https://raw.githubusercontent.com/git/git/${GIT_VERSION}/contrib/completion/git-completion.zsh
	ln -srf $@ zsh/completion/_git

${GIT_COMP_DIR}/git-completion.bash:
	mkdir -p $(@D)
	curl -L \
		-o $@ \
		https://raw.githubusercontent.com/git/git/${GIT_VERSION}/contrib/completion/git-completion.bash
	ln -srf $@ zsh/completion/git-completion.bash

${GHQ_COMP_DIR}/_ghq:
	mkdir -p $(@D)
	curl -L \
		-o $@ \
		https://raw.githubusercontent.com/x-motemen/ghq/${GHQ_VERSION}/misc/zsh/_ghq
	ln -srf $@ zsh/completion/_ghq

${KUBECTL_COMP_DIR}/_kubectl:
	mkdir -p $(@D)
	kubectl completion zsh > $@
	ln -srf $@ zsh/completion/_kubectl

${LOCAL_BIN}/checkstyle:
	mkdir -p $(@D)
	ln -sr contrib/checkstyle $@

${LOCAL_BIN}/google-java-format:
	mkdir -p $(@D)
	ln -sr contrib/google-java-format $@
