setlocal shiftwidth=2

if !exists('b:ale_fixers')
    let b:ale_fixers = ['prettier']
endif
