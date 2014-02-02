function python_prompt_info {
    if which python > /dev/null 2>&1; then
        if [[ -n $VIRTUAL_ENV ]]; then
            _DISPLAY="${${VIRTUAL_ENV}:t}"
        else;
            _DISPLAY="$(basename $(dirname $(dirname $(which python))))"
        fi
        echo "$ZSH_THEME_PYTHON_PROMPT_PREFIX$_DISPLAY$ZSH_THEME_PYTHON_PROMPT_SUFFIX"
        unset _DISPLAY
    fi
}
