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
  if [[ "${VIRTUAL_ENV}" =~ "venv$" ]]; then
    version=${VIRTUAL_ENV:h:t}
  elif [ -n "$VIRTUAL_ENV" ]; then
    version="${VIRTUAL_ENV:t}"
  else
    if (($+commands[python])); then
      version=`python --version 2>&1|cut -d' ' -f2`
    fi
    if (($+commands[python3])); then
      if [ -n "$version" ]; then
        version+="%{$fg[green]%},%{$fg[cyan]%}"
      fi
      version+=`python3 --version 2>&1|cut -d' ' -f2`
    fi
  fi
  if [ -n "$version" ]; then
    echo " %{$fg[green]%}py:%{$fg[cyan]%}${version}%{$reset_color%}"
  fi
}

function go_prompt_info() {
  local version
  if (($+commands[go])); then
    version="${$(go version|cut -d' ' -f3):s/go//}"
  fi
  if [ -n "$version" ]; then
    echo " %{$fg[green]%}go:%{$fg[cyan]%}${version}%{$reset_color%}"
  fi
}

PROMPT='$(vcs_prompt_info)%{$fg[cyan]%}%c %(?:%{$fg_bold[green]%}:%{$fg_bold[red]%})✘╹◡╹✘%{$reset_color%} '
RPROMPT='$(python_prompt_info)$(go_prompt_info)'
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
