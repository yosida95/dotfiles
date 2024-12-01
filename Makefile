LOCAL_BIN := ${HOME}/.local/bin
XDG_CONFIG_HOME ?= ${HOME}/.config
UNAME := $(shell uname)

GIT_VERSION := v$(shell git --version 2> /dev/null| cut -d ' ' -f 3)
GIT_VERSION_DIR := zsh/completion/git/${GIT_VERSION}

GHQ_VERSION := v$(shell ghq --version 2> /dev/null| cut -d ' ' -f 3)
GHQ_VERSION_DIR := zsh/completion/ghq/${GHQ_VERSION}

KUBECTL_VERSION := $(shell kubectl version --client --output json 2> /dev/null| jq -r .clientVersion.gitVersion)
KUBECTL_VERSION_DIR := zsh/completion/kubectl/${KUBECTL_VERSION}

KUSTOMIZE_VERSION := $(shell kustomize version 2> /dev/null)
KUSTOMIZE_VERSION_DIR := zsh/completion/kustomize/${KUSTOMIZE_VERSION}

REBAR_VERSION := $(shell rebar3 version 2> /dev/null| cut -d ' ' -f 2)
REBAR_VERSION_DIR := zsh/completion/rebar3/${REBAR_VERSION}

.PHONY: all
all: | ${HOME}/.dircolors \
		${XDG_CONFIG_HOME}/atuin/config.toml \
		${XDG_CONFIG_HOME}/git/config \
		${XDG_CONFIG_HOME}/git/config.gehirninc \
		${XDG_CONFIG_HOME}/git/ignore \
		${XDG_CONFIG_HOME}/yamllint/config \
		${HOME}/.hgrc \
		${HOME}/.lessfilter \
		${HOME}/.tmux.conf \
		${HOME}/.vim \
		${HOME}/.zshenv \
		${HOME}/.zshrc

${HOME}/.dircolors: third_party/dircolors-solarized/dircolors.256dark.no-bold
	ln -sfr $< $@

${XDG_CONFIG_HOME}/%: %
	mkdir -p $(@D)
	ln -srT $< $@

ifeq ($(UNAME),Darwin)
all: \
		${XDG_CONFIG_HOME}/karabiner \
		${XDG_CONFIG_HOME}/kitty/kitty.conf
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
${HOME}/.zshrc: | zsh/completion/autoload/_git

zsh/completion/autoload/_git: \
		${GIT_VERSION_DIR}/git-completion.zsh \
		zsh/completion/autoload/git-completion.bash
	mkdir -p $(@D)
	ln -srf $< $@
	rm -f ${HOME}/.zcompdump

zsh/completion/autoload/git-completion.bash: ${GIT_VERSION_DIR}/git-completion.bash
	mkdir -p $(@D)
	ln -srf $< $@

${GIT_VERSION_DIR}/git-completion.%:
	mkdir -p $(@D)
	curl -sSL \
		-o $@ \
		https://raw.githubusercontent.com/git/git/${GIT_VERSION}/contrib/completion/$(@F)

${GIT_VERSION_DIR}/git-completion.zsh: ${GIT_VERSION_DIR}/git-completion.bash
endif

ifneq (${GHQ_VERSION},v)
${HOME}/.zshrc: | zsh/completion/autoload/_ghq

zsh/completion/autoload/_ghq: ${GHQ_VERSION_DIR}/_ghq
	mkdir -p $(@D)
	ln -srf $< $@
	rm -f ${HOME}/.zcompdump

${GHQ_VERSION_DIR}/_ghq:
	mkdir -p $(@D)
	curl -sSL \
		-o $@ \
		https://raw.githubusercontent.com/x-motemen/ghq/${GHQ_VERSION}/misc/zsh/$(@F)
endif

ifneq (${KUBECTL_VERSION},)
${HOME}/.zshrc: | zsh/completion/autoload/_kubectl

zsh/completion/autoload/_kubectl: ${KUBECTL_VERSION_DIR}/_kubectl
	mkdir -p $(@D)
	ln -srf $< $@
	rm -f ${HOME}/.zcompdump

${KUBECTL_VERSION_DIR}/_kubectl:
	mkdir -p $(@D)
	kubectl completion zsh > $@
endif

ifneq (${KUSTOMIZE_VERSION},)
${HOME}/.zshrc: | zsh/completion/autoload/_kustomize

zsh/completion/autoload/_kustomize: ${KUSTOMIZE_VERSION_DIR}/_kustomize
	mkdir -p $(@D)
	ln -srf $< $@
	rm -f ${HOME}/.zcompdump

${KUSTOMIZE_VERSION_DIR}/_kustomize:
	mkdir -p $(@D)
	kustomize completion zsh > $@
endif

ifneq (${REBAR_VERSION},)
${HOME}/.zshrc: | zsh/completion/rebar3/_rebar3 zsh/completion/rebar3/_rebar3.zwc

zsh/completion/rebar3/_rebar3: ${REBAR_VERSION_DIR}/_build/default/_rebar3
	ln -srf $< $@

zsh/completion/rebar3/_rebar3.zwc: ${REBAR_VERSION_DIR}/_build/default/_rebar3
	zsh -c 'zcompile $@ $<'

${REBAR_VERSION_DIR}/_build/default/_rebar3:
	mkdir -p ${REBAR_VERSION_DIR}
	(cd ${REBAR_VERSION_DIR} && rebar3 completion --shell zsh)
endif
