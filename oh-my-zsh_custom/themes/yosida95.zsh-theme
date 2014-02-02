setopt prompt_subst
setopt transient_rprompt

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg[green]%}git:"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY=" %{$fg[yellow]%}-%{$reset_color%} "
ZSH_THEME_GIT_PROMPT_CLEAN=" "

ZSH_THEME_HG_PROMPT_PREFIX="%{$fg[green]%}hg:"
ZSH_THEME_HG_PROMPT_SUFFIX="%{$reset_color%}"
ZSH_THEME_HG_PROMPT_DIRTY=" %{$fg[yellow]%}-%{$reset_color%} "
ZSH_THEME_HG_PROMPT_CLEAN=" "

ZSH_THEME_PYTHON_PROMPT_PREFIX="%{$fg[cyan]%}py:"
ZSH_THEME_PYTHON_PROMPT_SUFFIX="%{$reset_color%} "

ZSH_THEME_GO_PROMPT_PREFIX="%{$fg[cyan]%}go:"
ZSH_THEME_GO_PROMPT_SUFFIX="%{$reset_color%} "

PROMPT='$(git_prompt_info)$(hg_prompt_info)%{$fg[cyan]%}%c %(?:%{$fg_bold[green]%}:%{$fg_bold[red]%})✘╹◡╹✘%{$reset_color%} '
RPROMPT='$(python_prompt_info)$(go_prompt_info)'
PROMPT2='%{$fg_bold[magenta]%}%_ %%%{$reset_color%} '
SPROMPT='%{$fg_bold[magenta]%}／人◕ ‿‿ ◕人＼ %{$fg_bold[red]%}%R%{$reset_color%}->%{$fg_bold[green]%}%r%{$reset_color%}? [%{$fg[green]%}y%{$reset_color%}, %{$fg[red]%}n%{$reset_color%}, %{$fg[yellow]%}e%{$reset_color%}, %{$fg[red]%}a%{$reset_color%}] '

# Change color of prompt on vi normal mode
# http://memo.officebrook.net/20090226.html
function zle-line-init zle-keymap-select {
    case $KEYMAP in
        vicmd)
            PROMPT='$(git_prompt_info)$(hg_prompt_info)%{$fg[blue]%}%c %(?:%{$fg_bold[green]%}:%{$fg_bold[red]%})✘╹◡╹✘%{$reset_color%} '
            ;;
        main|viins)
            PROMPT='$(git_prompt_info)$(hg_prompt_info)%{$fg[cyan]%}%c %(?:%{$fg_bold[green]%}:%{$fg_bold[red]%})✘╹◡╹✘%{$reset_color%} '
            ;;
    esac

    zle reset-prompt
}
zle -N zle-line-init
zle -N zle-keymap-select
