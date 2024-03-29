setopt PROMPT_SUBST
setopt TRANSIENT_RPROMPT
autoload -U colors && colors

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

  echo -n "%F{green}${vcs_info_msg_0_}%F{yellow}:%F{green}${vcs_info_msg_1_}"
  if [ -n "${vcs_info_msg_2_}${vcs_info_msg_3_}" ]; then
    echo -n " %F{yellow}${vcs_info_msg_2_}${vcs_info_msg_3_}"
  fi
  echo -n "%f "
}

function python_prompt_info() {
  if [ -n "$VIRTUAL_ENV" ]; then
    echo -n " %F{green}py:%F{cyan}${${${VIRTUAL_ENV:t}#.venv}:-${VIRTUAL_ENV:h:t}}%f"
  else
    local py2=${${(MOn)commands:#*/python2.[[:digit:]]##}[1]}
    local py3=${${(MOn)commands:#*/python3.[[:digit:]]##}[1]}
    if [ -n "$py2" ] || [ -n "$py3" ]; then
      echo -n " %F{green}py:"
      if [ -n "$py2" ]; then
        echo -n "%F{cyan}$($py2 --version 2>&1| cut -d' ' -f2)"
      fi
      if [ -n "py3" ]; then
        [ -z "$py2" ]  || echo -n "%F{green},"
        echo -n "%F{cyan}$($py3 --version 2>&1| cut -d' ' -f2)"
      fi
      echo -n "%f"
    fi
  fi
}

function go_prompt_info() {
  if (($+commands[go])); then
    echo " %F{green}go:%F{cyan}${$(go version| cut -d' ' -f3)#go}%f"
  fi
}

# Set to blue if $KEYMAP (defaults to "main" if unset) matches "vicmd", to green if the last exit code is 0, otherwise to red.
PROMPT='$(vcs_prompt_info)%F{cyan}%c %F{${${${${KEYMAP-main}:#vicmd}:+%(?:green:red)}:-blue}}✘╹◡╹✘%f '
RPROMPT='$(python_prompt_info)$(go_prompt_info)'
PROMPT2='%B%F{cyan}%_...%f%b '
SPROMPT='%B%F{magenta}／人◕ ‿‿ ◕人＼ %F{red}%R%f -> %F{green}%r%f%b [n/y/a/e]? '

# Change color of prompt on vi normal mode
# http://memo.officebrook.net/20090226.html
function zle-line-init zle-keymap-select { zle reset-prompt }
zle -N zle-line-init
zle -N zle-keymap-select
