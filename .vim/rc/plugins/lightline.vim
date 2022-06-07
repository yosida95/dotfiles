function! LightLineVerbose()
  return &filetype !~# '\vfern'
endfunction

function! LightLineFilename()
  let readonly = &readonly && &filetype !=# 'help' ? ' ' : ''
  let fname = expand('%:t') ==# '' ? '[No Name]' : expand('%:t')
  let modified = &modified ? ' +' : &modifiable ? '' : ' -'
  return readonly . fname . modified
endfunction

function! LightLineMode()
  return &filetype ==# 'fern' ? 'Fern' : lightline#mode()
endfunction

function! LightLineFugitive()
  if LightLineVerbose()
    let head = FugitiveHead()
    if head !=# ''
      return ' ' . head
    endif
  endif
  return ''
endfunction

let g:lightline = {
    \ 'colorscheme': 'wombat',
    \ 'active': {
    \   'left': [['mode', 'paste'], ['fugitive', 'filename']],
    \   'right': [['lineinfo'],
    \             ['percent'],
    \             ['fileformat', 'fileencoding', 'filetype'],
    \             ['linter_checking', 'linter_errors', 'linter_warnings', 'linter_infos', 'linter_ok']],
    \ },
    \ 'inactive': {
    \   'left': [['filename']],
    \   'right': [['lineinfo'], ['percent']],
    \ },
    \ 'component': {
    \   'lineinfo': '%{%LightLineVerbose() ? ''%3l:%-2c'' : ''''%}',
    \   'percent': '%{%LightLineVerbose() ? ''%3p%%'' : ''''%}',
    \   'fileformat': '%{LightLineVerbose() ? &ff : ''''}',
    \   'fileencoding': '%{LightLineVerbose() ? &fenc !=# "" ? &fenc : &enc : ''''}',
    \   'filetype': '%{LightLineVerbose() ? &ft !=# "" ? &ft : "no ft" : ''''}',
    \ },
    \ 'component_visible_condition': {
    \   'lineinfo': 'LightLineVerbose()',
    \   'percent': 'LightLineVerbose()',
    \   'fileformat': 'LightLineVerbose()',
    \   'fileencoding': 'LightLineVerbose()',
    \   'filetype': 'LightLineVerbose()',
    \ },
    \ 'component_function': {
    \   'mode': 'LightLineMode',
    \   'fugitive': 'LightLineFugitive',
    \   'filename': 'LightLineFilename',
    \ },
    \ 'component_function_visible_condition': {
    \   'mode': '1',
    \   'filename': '1',
    \ },
    \ 'component_expand': {
    \   'linter_checking': 'lightline#ale#checking',
    \   'linter_infos': 'lightline#ale#infos',
    \   'linter_warnings': 'lightline#ale#warnings',
    \   'linter_errors': 'lightline#ale#errors',
    \   'linter_ok': 'lightline#ale#ok',
    \ },
    \ 'component_type': {
    \   'linter_checking': 'right',
    \   'linter_infos': 'right',
    \   'linter_warnings': 'warning',
    \   'linter_errors': 'error',
    \   'linter_ok': 'right',
    \ },
    \ 'separator': {
    \   'left': '', 'right': ''
    \ },
    \ 'subseparator': {
    \   'left': '', 'right': ''
    \ }}
