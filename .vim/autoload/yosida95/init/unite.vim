function! yosida95#init#unite#hook_add() abort
    nmap <buffer> <ESC> <Plug>(unite_exit)
    autocmd BufEnter * if (winnr('$') == 1 && &filetype ==# 'vimfiler') | q | endif

    noremap <C-B> :Unite buffer<CR>
    noremap <C-F> :Unite file file/new<CR>
endfunction
