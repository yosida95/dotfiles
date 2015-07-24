setopt transient_rprompt

bindkey -v  # use vi like keybind

autoload -Uz add-zsh-hook
autoload -Uz vcs_info
add-zsh-hook precmd vcs_info

zstyle ':vcs_info:*' enable git hg
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:hg:*' get-revision true
zstyle ':vcs_info:hg:*' branchformat '%b'

zstyle ':vcs_info:*' formats '%s' '%b' '%c' '%u'
zstyle ':vcs_info:*' max-exports 4
zstyle ':vcs_info:*' stagedstr '+'
zstyle ':vcs_info:*' unstagedstr '-'

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

ZSH_THEME_PYTHON_PROMPT_PREFIX="%{$fg[cyan]%}py:"
ZSH_THEME_PYTHON_PROMPT_SUFFIX="%{$reset_color%} "

ZSH_THEME_GO_PROMPT_PREFIX="%{$fg[cyan]%}go:"
ZSH_THEME_GO_PROMPT_SUFFIX="%{$reset_color%}"

ZSH_THEME_RBENV_PROMPT_PREFIX="%{$fg[cyan]%}rb:"
ZSH_THEME_RBENV_PROMPT_SUFFIX="%{$reset_color%}"

PROMPT='$(vcs_prompt_info)%{$fg[cyan]%}%c %(?:%{$fg_bold[green]%}:%{$fg_bold[red]%})✘╹◡╹✘%{$reset_color%} '
RPROMPT='$(python_prompt_info) $(go_prompt_info) $(rbenv_prompt_info)'
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

# vim: set filetype=zsh:
