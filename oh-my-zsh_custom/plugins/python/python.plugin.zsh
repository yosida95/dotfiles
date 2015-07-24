# Find python file
alias pyfind='find . -name "*.py"'

# Remove python compiled byte-code in either current directory or in a
# list of specified directories
function pyclean() {
    ZSH_PYCLEAN_PLACES=${*:-'.'}
    find ${ZSH_PYCLEAN_PLACES} -type f -name "*.py[co]" -delete
    find ${ZSH_PYCLEAN_PLACES} -type d -name "__pycache__" -delete
}

# Grep among .py files
alias pygrep='grep --include="*.py"'

export VIRTUAL_ENV_DISABLE_PROMPT=1

function python_prompt_info {
    if which python > /dev/null 2>&1; then
        if [[ -n $VIRTUAL_ENV ]]; then
            _DISPLAY="${${VIRTUAL_ENV}:t}"
            if [[ $_DISPLAY == "venv" || $_DISPLAY == ".venv" ]]; then
                    _DISPLAY="${${${VIRTUAL_ENV}:h}:t}"
            fi
        else;
            _DISPLAY="$(basename $(dirname $(dirname $(which python))))"
        fi
        echo "$ZSH_THEME_PYTHON_PROMPT_PREFIX$_DISPLAY$ZSH_THEME_PYTHON_PROMPT_SUFFIX"
        unset _DISPLAY
    fi
}
