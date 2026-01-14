function! yosida95#HasNodeDependency(name) abort
  let l:prev = expand('%:p')
  let l:dir = fnamemodify(l:prev, ':h')
  while l:prev != l:dir
    let l:package = l:dir . (l:dir =~ '/$' ? '' : '/') . 'package.json'
    if filereadable(l:package)
      let l:decoded = json_decode(join(readfile(l:package), "\n"))
      let l:dependencies = get(l:decoded, 'dependencies', {})
      let l:dev_dependencies = get(l:decoded, 'devDependencies', {})
      return has_key(l:dependencies, a:name) || has_key(l:dev_dependencies, a:name)
    endif
    let l:prev = l:dir
    let l:dir = fnamemodify(l:dir, ':h')
  endwhile
  return v:false
endfunction
