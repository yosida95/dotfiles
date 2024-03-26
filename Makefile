LOCAL_BIN := ${HOME}/.local/bin
XDG_CONFIG_HOME ?= ${HOME}/.config
UNAME := $(shell uname)

ZSH_COMPLETION := zsh/completion

GIT_VERSION := v$(shell git --version 2> /dev/null| cut -d ' ' -f 3)
GIT_VERSION_DIR := ${ZSH_COMPLETION}/git/${GIT_VERSION}

GHQ_VERSION := v$(shell ghq --version 2> /dev/null| cut -d ' ' -f 3)
GHQ_VERSION_DIR := zsh/completion/ghq/${GHQ_VERSION}

KUBECTL_VERSION := $(shell kubectl version --client --output json 2> /dev/null| jq -r .clientVersion.gitVersion)
KUBECTL_VERSION_DIR := zsh/completion/kubectl/${KUBECTL_VERSION}

.PHONY: all
all: | ${HOME}/.dircolors \
		${XDG_CONFIG_HOME}/git/config \
		${XDG_CONFIG_HOME}/git/config.gehirninc \
		${XDG_CONFIG_HOME}/git/ignore \
		${XDG_CONFIG_HOME}/kitty/kitty.conf \
		${HOME}/.hgrc \
		${HOME}/.lessfilter \
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

${XDG_CONFIG_HOME}/kitty/kitty.conf:
	mkdir -p $(@D)
	ln -sr kitty.conf $@

ifeq ($(UNAME),Darwin)
all: | ${XDG_CONFIG_HOME}/karabiner

${XDG_CONFIG_HOME}/karabiner: .config/karabiner
	ln -srT $< $@
endif

${HOME}/.hgrc: | ${HOME}/.hgignore
	ln -sr .hgrc $@

${HOME}/.hgignore:
	ln -sr .hgignore $@

${HOME}/.lessfilter:
	ln -sr .lessfilter $@

${HOME}/.tmux.conf:
	ln -sr .tmux.conf $@

${HOME}/.vim: | \
		${HOME}/.cache/vimbackup \
		${HOME}/.cache/vimswap \
		${HOME}/.cache/vimundo \
		${HOME}/.local/share/vim-lsp-settings/settings.json
	ln -sr .vim $@

${HOME}/.cache/vimbackup ${HOME}/.cache/vimswap ${HOME}/.cache/vimundo:
	mkdir -p $@

${HOME}/.local/share/vim-lsp-settings/settings.json:
	mkdir -p $(@D)
	ln -srf ./.vim/vim-lsp-settings.json $@

${HOME}/.zshenv:
	ln -sr ./.zshenv $@

${HOME}/.zshrc:
	ln -sr ./.zshrc $@

ifneq (${GIT_VERSION},v)
${HOME}/.zshrc: | ${ZSH_COMPLETION}/_git

${ZSH_COMPLETION}/_git: \
		${GIT_VERSION_DIR}/git-completion.zsh \
		${ZSH_COMPLETION}/git-completion.bash
	ln -srf $< $@
	rm -f ${HOME}/.zcompdump

${ZSH_COMPLETION}/git-completion.bash: ${GIT_VERSION_DIR}/git-completion.bash
	ln -srf $< $@

${GIT_VERSION_DIR}/git-completion.%:
	mkdir -p $(@D)
	curl -sSL \
		-o $@ \
		https://raw.githubusercontent.com/git/git/${GIT_VERSION}/contrib/completion/$(@F)

${GIT_VERSION_DIR}/git-completion.zsh: ${GIT_VERSION_DIR}/git-completion.bash
endif

ifneq (${GHQ_VERSION},v)
${HOME}/.zshrc: | ${ZSH_COMPLETION}/_ghq

${ZSH_COMPLETION}/_ghq: ${GHQ_VERSION_DIR}/_ghq
	ln -srf $< $@
	rm -f ${HOME}/.zcompdump

${GHQ_VERSION_DIR}/_ghq:
	mkdir -p $(@D)
	curl -sSL \
		-o $@ \
		https://raw.githubusercontent.com/x-motemen/ghq/${GHQ_VERSION}/misc/zsh/$(@F)
endif

ifneq (${KUBECTL_VERSION},)
${HOME}/.zshrc: | ${ZSH_COMPLETION}/_kubectl

${ZSH_COMPLETION}/_kubectl: ${KUBECTL_VERSION_DIR}/_kubectl
	ln -srf $< $@
	rm -f ${HOME}/.zcompdump

${KUBECTL_VERSION_DIR}/_kubectl:
	mkdir -p $(@D)
	kubectl completion zsh > $@
endif
