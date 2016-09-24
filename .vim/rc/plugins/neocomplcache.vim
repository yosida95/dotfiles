let g:neocomplcache_enable_at_startup = 1
let g:neocomplcache_min_keyword_length = 2
let g:neocomplcache_min_syntax_length = 2
let g:neocomplcache_enable_ignore_case = 1
let g:neocomplcache_enable_smart_case = 1
let g:neocomplcache_enable_wildcard = 1
let g:neocomplcache_enable_auto_select = 0
let g:neocomplcache_enable_auto_delimiter = 1
let g:neocomplcache_enable_camel_case_completion = 1
let g:neocomplcache_enable_underbar_completion = 1
let g:neocomplcache_enable_caching_message = 0

let g:neocomplcache_omni_functions = {
    \ 'css': 'csscomplete#CompleteCSS',
    \ 'erlang': 'erlang_complete#Complete',
    \ 'html': 'htmlcomplete#CompleteTags',
    \ 'javascript': 'javascriptcomplete#CompleteJS',
    \ 'markdown': 'htmlcomplete#CompleteTags',
    \ 'xml': 'xmlcomplete#CompleteTags',
    \ }
let g:neocomplcache_force_omni_patterns = {
    \ 'go': '\h\w*\.\?',
    \ }

" Plugin key-mappings.
inoremap <expr><C-g> neocomplcache#undo_completion()
inoremap <expr><C-l> neocomplcache#complete_common_string()
inoremap <expr><C-y> neocomplcache#close_popup()
inoremap <expr><C-e> neocomplcache#cancel_popup()
" <CR>: close popup and save indent.
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
    return neocomplcache#smart_close_popup() . "\<CR>"
endfunction
" <Tab>: completion.
inoremap <expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
" <C-h>, <BS>: close popup and delete backwork char.
inoremap <expr><C-h> neocomplcache#smart_close_popup()."\<C-h>"
inoremap <expr><BS>  neocomplcache#smart_close_popup()."\<C-h>"
