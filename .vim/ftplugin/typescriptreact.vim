setlocal shiftwidth=2

function! s:has_dependency(package, name) abort
    if filereadable(a:package)
        let l:decoded = json_decode(join(readfile(a:package), "\n"))
        let l:dependencies = get(l:decoded, 'dependencies', {})
        let l:dev_dependencies = get(l:decoded, 'devDependencies', {})
        return has_key(l:dependencies, a:name) || has_key(l:dev_dependencies, a:name)
        break
    endif
    return v:false
endfunction

let s:current = expand('%:p')
let s:next = fnamemodify(s:current, ':h')
while s:current != s:next
    let s:current = s:next
    let s:package = s:current . (s:current =~ '/$' ? '' : '/') . 'package.json'
    if filereadable(s:package)
        if s:has_dependency(s:package, 'postcss-styled-syntax')
            let b:ale_linter_aliases = ['css', 'typescript', 'tsx']
            let b:ale_fixers = ['prettier', 'stylelint']
        endif
        break
    endif
    let s:next = fnamemodify(s:current, ':h')
endwhile
