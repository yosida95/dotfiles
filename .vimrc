"============================"
"          Plugins           "
"============================"
set nocompatible
filetype plugin indent off

if has('vim_starting')
    set nocompatible
    set runtimepath+=~/.vim/bundle/neobundle.vim
endif

call neobundle#rc(expand('~/.vim/bundle'))

" vimproc
" NeoBundle 'Shougo/vimproc'

NeoBundleFetch 'Shougo/neobundle.vim'

NeoBundle "Shougo/vimproc", {
    \ "build": {
    \   "windows"   : "make -f make_mingw32.mak",
    \   "cygwin"    : "make -f make_cygwin.mak",
    \   "mac"       : "make -f make_mac.mak",
    \   "unix"      : "make -f make_unix.mak",
    \ }}

" neocomplcache
NeoBundle 'Shougo/neocomplcache'
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
if !exists('g:neocomplcache_omni_patterns')
    let g:neocomplcache_omni_patterns = {}
endif
let g:neocomplcache_omni_patterns.go = '.'
inoremap <expr><C-g> neocomplcache#undo_completion()
inoremap <expr><C-l> neocomplcache#complete_common_string()
inoremap <expr><CR>  neocomplcache#close_popup() . "\<CR>"
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
inoremap <expr><C-h>  neocomplcache#smart_close_popup()."\<C-h>"
inoremap <expr><BS>  neocomplcache#smart_close_popup()."\<C-h>"
inoremap <expr><C-y> neocomplcache#close_popup()
inoremap <expr><C-e> neocomplcache#cancel_popup()

" unite.vim
NeoBundle 'Shougo/unite.vim'
let g:unite_update_time = 100
let g:unite_enable_start_insert = 1
let g:unite_winheight = 15
noremap <C-B> :Unite buffer<CR>
noremap <C-F> :Unite file file/new<CR>
nmap <buffer> <ESC> <Plug>(unite_exit)
au FileType unite nnoremap <silent> <buffer> <ESC><ESC> :q<CR>
au FileType unite inoremap <silent> <buffer> <ESC><ESC> <ESC>:q<CR>
autocmd BufEnter * if (winnr('$') == 1 && &filetype ==# 'vimfiler') | q | endif

" vimfiler.vim
NeoBundle 'Shougo/vimfiler.vim', {
    \ "depends": ["Shougo/unite.vim"]
    \ }
let g:vimfiler_as_default_explorer = 1
nnoremap <leader>e :VimFilerExplorer<CR>

" Tagbar
NeoBundle 'Tagbar'
nmap <F8> :TagbarToggle<CR>

" quickrun.vim
NeoBundle 'quickrun.vim'
augroup QuickRunUnitTest
    autocmd!
    autocmd BufWinEnter,BufNewFile test_*.py set filetype=python.unit
augroup END

let g:quickrun_config = {}
let g:quickrun_config['*'] = {'runmode': "async:remote:vimproc", 'split': 'below'}
let g:quickrun_config['python.unit'] = {'command': 'nosetests', 'cmdopt': '--verbose --with-doctest --with-coverage'}

" virtualenv.vim
NeoBundle "jmcantrell/vim-virtualenv"

" jedi-vim
NeoBundle "davidhalter/jedi-vim"
" let g:jedi#auto_initialization = 1
let g:jedi#auto_vim_configuration = 0
let g:jedi#rename_command = '<Leader>R'
let g:jedi#popup_on_dot = 1
let g:jedi#popup_select_first = 0
autocmd FileType python let b:did_ftplugin = 1

" vim-coffee-script
NeoBundle 'vim-coffee-script'

" Protocol Buffers
NeoBundle 'uarun/vim-protobuf'

" Markdown
NeoBundle 'Markdown'

" Mako
NeoBundle 'mako.vim'
autocmd BufNewFile,BufRead *.mak set filetype=mako

" Jinja2
NeoBundle 'Jinja'
NeoBundle 'https://github.com/estin/htmljinja.git'
autocmd BufNewFile,BufRead *.jinja2 set filetype=htmljinja

" html5.vim
NeoBundle 'othree/html5.vim'

" sudo.vim
NeoBundle 'sudo.vim'

" vim-fugitive
NeoBundle "tpope/vim-fugitive"

NeoBundle "gregsexton/gitv", {
    \ "depends": ["tpope/vim-fugitive"]
    \ }
nnoremap <leader>g :Gitv<CR>
" autocmd FileType git :setlocal foldlevel=99

" hybrid.vim
NeoBundle 'hybrid.vim'
let g:hybrid_use_Xresources = 1
colorscheme hybrid

NeoBundleCheck

" go
set rtp+=$GOROOT/misc/vim
set completeopt=menu,preview

filetype plugin indent on
syntax enable

NeoBundleCheck

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

"============================"
"           Search           "
"============================"
set noignorecase
set nosmartcase
set incsearch
set hlsearch
nnoremap n nzz
nnoremap N Nzz
nnoremap * *zz
nnoremap # #zz
nnoremap g* g*zz
nnoremap g# g#zz
cnoremap <expr> / getcmdtype() == '/' ? '\/' : '/'
cnoremap <expr> ? getcmdtype() == '?' ? '\?' : '?'
nmap <Esc><Esc> :noh<CR>

"============================"
"          Display           "
"============================"
set number
set list
set listchars=tab:»-,trail:-,extends:»,precedes:«,eol:$,nbsp:%
set showmatch
set matchtime=3
set matchpairs& matchpairs+=<:>
set nowrap
set colorcolumn=80
hi Pmenu ctermbg=blue
hi PmenuSel term=bold ctermfg=white ctermbg=darkred
hi PMenuSbar ctermbg=blue

" Status line
set laststatus=2
set statusline=%<%f\%m%r%h%w%{'['.(&fenc!=''?&fenc:&enc).']['.&ff.']'}%{fugitive#statusline()}%=%l,%c%V%8P

" Cursorline
augroup vimrc-auto-cursorline
    autocmd!
    autocmd CursorMoved,CursorMovedI,WinLeave * setlocal nocursorline
    autocmd CursorHold,CursorMovedI * setlocal cursorline
augroup END

" Indent
set autoindent
set smartindent
set smarttab
set expandtab
set softtabstop=0
set tabstop=4
set shiftwidth=4
set shiftround

"Mouse
set mouse= " Disable mouse

set completeopt-=preview
