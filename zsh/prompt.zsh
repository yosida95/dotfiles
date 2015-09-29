# vim: set filetype=zsh :

setopt PROMPT_SUBST
setopt TRANSIENT_RPROMPT
autoload -U colors && colors

bindkey -v  # use vi like keybind

zstyle ':vcs_info:*' enable git hg
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:hg:*' get-revision true
zstyle ':vcs_info:hg:*' branchformat '%b'

zstyle ':vcs_info:*' formats '%s' '%b' '%c' '%u'
zstyle ':vcs_info:*' max-exports 4
zstyle ':vcs_info:*' stagedstr '+'
zstyle ':vcs_info:*' unstagedstr '-'

autoload -Uz add-zsh-hook
autoload -Uz vcs_info
add-zsh-hook precmd vcs_info

function vcs_prompt_info () {
    if [ -z $vcs_info_msg_0_ ]; then
        return 0
    fi

    echo -n "%{$fg[green]%}${vcs_info_msg_0_}%{$fg[yellow]%}:"
    echo -n "%{$fg[green]%}${vcs_info_msg_1_}"
    if [ -n "${vcs_info_msg_2_}${vcs_info_msg_3_}" ]; then
        echo -n " %{$fg[yellow]%}${vcs_info_msg_2_}${vcs_info_msg_3_}"
    fi
    echo -n "%{$reset_color%} "
}

export VIRTUAL_ENV_DISABLE_PROMPT=1
function python_prompt_info() {
    local version
    if [ -n "$VIRTUAL_ENV" ]; then
        version="${VIRTUAL_ENV:t}"
        case "$version" in
            "venv" | ".venv")
                version=${VIRTUAL_ENV:h:t}
                ;;
        esac
    elif (($+commands[python])) && (($+commands[python3])); then
        version="$(python --version 2>&1| cut -d' ' -f2)%{$fg[green]%},"
        version+="%{$fg[cyan]%}$(python3 --version 2>&1| cut -d' ' -f2)"
    elif (($+commands[python])); then
        version="$(python --version 2>&1| cut -d' ' -f2)"
    elif (($+commands[python3])); then
        version="$(python3 --version 2>&1| cut -d' ' -f2)"
    else
        echo ""
    fi

    if [ -n "$version" ]; then
        echo " %{$fg[green]%}py:%{$fg[cyan]%}${version}%{$reset_color%}"
    else
        echo ""
    fi
}

function go_prompt_info() {
    if (($+commands[go])); then
        if [ -n "$GOPATH" ]; then
            local version=${GOPATH:t}
        else
            local version="${$(go version| cut -d' ' -f 3):s/go//}"
        fi
        echo " %{$fg[green]%}go:%{$fg[cyan]%}${version}%{$reset_color%}"
    else
        echo ""
    fi
}

function ruby_prompt_info() {
    if (($+commands[ruby])); then
        echo " %{$fg[green]%}rb:%{$fg[cyan]%}$(ruby -v| cut -d ' ' -f 2)%{$reset_color%}"
    else
        echo ""
    fi
}

PROMPT='$(vcs_prompt_info)%{$fg[cyan]%}%c %(?:%{$fg_bold[green]%}:%{$fg_bold[red]%})✘╹◡╹✘%{$reset_color%} '
RPROMPT='$(python_prompt_info)$(go_prompt_info)$(ruby_prompt_info)'
PROMPT2='%{$fg_bold[magenta]%}%_ %%%{$reset_color%} '
SPROMPT='%{$fg_bold[magenta]%}／人◕ ‿‿ ◕人＼ %{$fg_bold[red]%}%R%{$reset_color%}->%{$fg_bold[green]%}%r%{$reset_color%}? [%{$fg[green]%}y%{$reset_color%}, %{$fg[red]%}n%{$reset_color%}, %{$fg[yellow]%}e%{$reset_color%}, %{$fg[red]%}a%{$reset_color%}] '

# Change color of prompt on vi normal mode
# http://memo.officebrook.net/20090226.html
function zle-line-init zle-keymap-select {
    case $KEYMAP in
        vicmd)
            PROMPT='$(vcs_prompt_info)%{$fg[blue]%}%c %(?:%{$fg_bold[green]%}:%{$fg_bold[red]%})✘╹◡╹✘%{$reset_color%} '
            ;;
        main|viins)
            PROMPT='$(vcs_prompt_info)%{$fg[cyan]%}%c %(?:%{$fg_bold[green]%}:%{$fg_bold[red]%})✘╹◡╹✘%{$reset_color%} '
            ;;
    esac

    zle reset-prompt
}
zle -N zle-line-init
zle -N zle-keymap-select
