set nocompatible
filetype off

" Vundle
set rtp+=~/.vim/vundle.git/
call vundle#rc()

" unite.vim
Bundle 'unite.vim'
let g:unite_enable_start_insert = 1
let g:unite_winheight = 15
let g:unite_update_time = 100
noremap <C-B> :Unite buffer<CR>
noremap <C-F> :Unite file file/new<CR>
nmap <buffer> <ESC> <Plug>(unite_exit)
au FileType unite nnoremap <silent> <buffer> <ESC><ESC> :q<CR>
au FileType unite inoremap <silent> <buffer> <ESC><ESC> <ESC>:q<CR>

"neocomplcache
Bundle 'neocomplcache'
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
if has('unix')
    let g:neocomplcache_temporary_dir = '/tmp/.neocon-' . $USER
endif
inoremap <expr><C-g> neocomplcache#undo_completion()
inoremap <expr><C-l> neocomplcache#complete_common_string()
inoremap <expr><CR>  neocomplcache#close_popup() . "\<CR>"
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
inoremap <expr><C-h>  neocomplcache#smart_close_popup()."\<C-h>"
inoremap <expr><BS>  neocomplcache#smart_close_popup()."\<C-h>"
inoremap <expr><C-y> neocomplcache#close_popup()
inoremap <expr><C-e> neocomplcache#cancel_popup()

" ZenCoding.vim
Bundle 'ZenCoding.vim'
let g:user_zen_leader_key = '<C-z>'
let g:use_zen_complete_tag = 1
let g:user_zen_settings = {'indentation': '    '}

" Tagbar
Bundle 'Tagbar'
nmap <F8> :TagbarToggle<CR>

" quickrun.vim
Bundle 'quickrun.vim'
augroup QuickRunUnitTest
    autocmd!
    autocmd BufWinEnter,BufNewFile test_*.py set filetype=python.unit
augroup END

let g:quickrun_config = {}
let g:quickrun_config['*'] = {'runmode': "async:remote:vimproc", 'split': 'below'}
let g:quickrun_config['python.unit'] = {'command': 'nosetests', 'cmdopt': '--verbose --with-doctest --with-coverage'}

" wombat256.vim
Bundle 'wombat256.vim'
set t_Co=256
colorscheme wombat256mod

" sudo.vim
Bundle 'sudo.vim'

" vim-coffee-script
Bundle 'vim-coffee-script'

Bundle 'Jinja'

" go
set rtp+=$GOROOT/misc/vim

filetype plugin indent on
syntax enable

" Encodings
set enc=utf-8
set fenc=utf-8
set fencs=utf-8,euc-jp,sjis,cp932,iso-2022-jp
set fileformats=unix,mac,dos

" Buffer
set autowrite
set hidden

" Backup
set backup
set backupdir=$HOME/.vim-backup
let &directory = &backupdir

" Cursorline
augroup vimrc-auto-cursorline
    autocmd!
    autocmd CursorMoved,CursorMovedI,WinLeave * setlocal nocursorline
    autocmd CursorHold,CursorMovedI * setlocal cursorline
augroup END

" Search
set hlsearch
set incsearch
nmap <Esc><Esc> :noh<CR>

" Display
set number
set list
set listchars=tab:>~,trail:~,eol:$,extends:>,precedes:<
set showmatch
set nowrap
hi Pmenu ctermbg=blue
hi PmenuSel term=bold ctermfg=white ctermbg=darkred
hi PMenuSbar ctermbg=blue

set laststatus=2 " Status line
set statusline=%<%f\%m%r%h%w%{'['.(&fenc!=''?&fenc:&enc).']['.&ff.']'}%=%l,%c%V%8P " Status line format

" Indent
set autoindent
set smartindent
set expandtab
set softtabstop=4
set shiftwidth=4

"Mouse
set mouse= " Disable mouse

set completeopt-=preview
