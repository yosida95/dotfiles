function go_prompt_info {
    if which go > /dev/null 2>&1; then
        _DISPLAY=$(basename $(dirname $(dirname $(which go))))
        echo "$ZSH_THEME_GO_PROMPT_PREFIX$_DISPLAY$ZSH_THEME_GO_PROMPT_SUFFIX"
        unset _DISPLAY
    fi
}

