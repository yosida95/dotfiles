""""""""""""""""""""
" Generic
""""""""""""""""""""
syntax enable
set backspace=indent,eol,start

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
set backupdir=$HOME/.vim/backup

" Swap
set swapfile
set directory=$HOME/.vim/swap

" Undo
set undofile
set undodir=$HOME/.vim/undo

""""""""""""""""""""
" Completion
""""""""""""""""""""
set completeopt=menu,preview

""""""""""""""""""""
" Indentation
""""""""""""""""""""
set autoindent
set smartindent
set smarttab
set expandtab
set softtabstop=0
set tabstop=4
set shiftwidth=4
set shiftround

""""""""""""""""""""
" Search
""""""""""""""""""""
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

""""""""""""""""""""
" neobundle.vim
""""""""""""""""""""
if has('vim_starting')
    if &compatible
        set nocompatible
    endif

    set runtimepath+=~/.vim/bundle/neobundle.vim
endif

call neobundle#begin(expand('~/.vim/bundle'))
NeoBundleFetch 'Shougo/neobundle.vim'

let g:neobundle#types#git#default_protocol = 'https'

""""""""""""""""""""
" Hybrid.vim
""""""""""""""""""""
NeoBundle 'hybrid.vim'

let s:bundle = neobundle#get("hybrid.vim")
function! s:bundle.hooks.on_source(bundle)
    let g:hybrid_use_Xresources = 1
    colorscheme hybrid
endfunction
unlet s:bundle

""""""""""""""""""""
" sudo.vim
""""""""""""""""""""
NeoBundle 'sudo.vim'

""""""""""""""""""""
" neocomplcache.vim
""""""""""""""""""""
NeoBundle 'Shougo/neocomplcache'

let s:bundle = neobundle#get('neocomplcache')
function! s:bundle.hooks.on_source(bundle)
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
        \ 'go': 'gocomplete#Complete',
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
endfunction
unlet s:bundle

""""""""""""""""""""
" unite.vim
""""""""""""""""""""
NeoBundleLazy 'Shougo/unite.vim', {
    \ 'autoload' : {
    \     'commands' : ['Unite']
    \ }}

let s:bundle = neobundle#get('unite.vim')
function! s:bundle.hooks.on_source(bundle)
    let g:unite_update_time = 100
    let g:unite_enable_start_insert = 1
    let g:unite_winheight = 15
    au FileType unite nnoremap <silent> <buffer> <ESC><ESC> :q<CR>
    au FileType unite inoremap <silent> <buffer> <ESC><ESC> <ESC>:q<CR>

    nmap <buffer> <ESC> <Plug>(unite_exit)
    autocmd BufEnter * if (winnr('$') == 1 && &filetype ==# 'vimfiler') | q | endif
endfunction
unlet s:bundle

noremap <C-B> :Unite buffer<CR>
noremap <C-F> :Unite file file/new<CR>

""""""""""""""""""""
" vimfiler.vim
""""""""""""""""""""
NeoBundleLazy 'Shougo/vimfiler.vim', {
    \ 'depends': ['Shougo/unite.vim'],
    \ 'autoload' : {
    \     'commands' : ['VimFilerTab', 'VimFiler', 'VimFilerExplorer']
    \ }}

let s:bundle = neobundle#get('vimfiler.vim')
function! s:bundle.hooks.on_source(bundle)
    let g:vimfiler_as_default_explorer = 1
endfunction
unlet s:bundle

nnoremap <leader>e :VimFilerExplorer<CR>

""""""""""""""""""""
" Tagbar
""""""""""""""""""""
NeoBundle 'Tagbar'

let s:bundle = neobundle#get('Tagbar')
function! s:bundle.hooks.on_source(bundle)
    nmap <F8> :TagbarToggle<CR>
endfunction
unlet s:bundle

"""""""""""""""""""
" quickrun.vim
"""""""""""""""""""
NeoBundle 'Shougo/vimproc.vim', {
    \ 'build' : {
    \     'windows': 'tools\\update-dll-mingw',
    \     'cygwin' : 'make -f make_cygwin.mak',
    \     'mac'    : 'make -f make_mac.mak',
    \     'linux'  : 'make',
    \     'unix'   : 'gmake',
    \ }}

NeoBundle 'thinca/vim-quickrun', {
    \ 'depends': ['Shougo/vimproc.vim'],
    \ }

let s:bundle = neobundle#get('vim-quickrun')
function! s:bundle.hooks.on_source(bundle)
    let g:quickrun_config = {
        \ '_': {
        \     'runner': 'vimproc',
        \     'runner/vimproc/updatetime': 50,
        \ },
        \ '*': {
        \     'runmode': 'async:remote:vimproc',
        \     'split': 'below',
        \ }}
endfunction
unlet s:bundle

""""""""""""""""""""
" watchdogs.vim
""""""""""""""""""""
NeoBundle 'cohama/vim-hier'
NeoBundle 'dannyob/quickfixstatus'
NeoBundle 'osyo-manga/shabadou.vim'
NeoBundle 'osyo-manga/vim-watchdogs', {
    \ 'depends': ['osyo-manga/shabadou.vim',
    \             'cohama/vim-hier',
    \             'dannyob/quickfixstatus',
    \             'thinca/vim-quickrun'],
    \ }

let s:bundle = neobundle#get('vim-watchdogs')
function! s:bundle.hooks.on_source(bundle)
    let g:watchdogs_check_BufWritePost_enable = 1
    let g:watchdogs_check_CursorHold_enable = 1

    let g:quickrun_config['watchdogs_checker/_'] = {
        \ 'outputter/quickfix/open_cmd' : '',
        \ }
    let g:quickrun_config['python/watchdogs_checker'] = {
        \ 'type': 'watchdogs_checker/flake8',
        \ }
    call watchdogs#setup(g:quickrun_config)
endfunction
unlet s:bundle

""""""""""""""""""""
" gitv
""""""""""""""""""""
NeoBundle 'tpope/vim-fugitive'
NeoBundleLazy 'gregsexton/gitv', {
    \ 'depends': ['tpope/vim-fugitive'],
    \ 'autoload' : {
    \     'commands' : ['Gitv']
    \ }}
nnoremap <leader>g :Gitv<CR>

""""""""""""""""""""
" ABNF
""""""""""""""""""""
autocmd BufNewFile,BufRead *.abnf,*.bnf set filetype=abnf
NeoBundleLazy 'abnf', {
    \ 'autoload': {
    \   'filetypes': ['abnf'],
    \ }}

""""""""""""""""""""
" blockdiag
""""""""""""""""""""
NeoBundle 'mhaig/vim-blockdiag-series'

""""""""""""""""""""
" Coffee Script
""""""""""""""""""""
autocmd BufNewFile,BufRead *.coffee set filetype=coffee
NeoBundle 'kchmck/vim-coffee-script'

""""""""""""""""""""
" Dart
""""""""""""""""""""
autocmd BufRead,BufNewFile *.dart set filetype=dart
NeoBundleLazy 'dart-lang/dart-vim-plugin', {
    \ 'autoload': {
    \     'filetypes': ['dart']
    \ }}

""""""""""""""""""""
" Go
""""""""""""""""""""
NeoBundle 'fatih/vim-go'
NeoBundle 'google/vim-ft-go'
NeoBundleLazy 'nsf/gocode', {
    \ 'rtp': 'vim/',
    \ 'autoload': {
    \     'filetypes': ['go'],
    \ }}

""""""""""""""""""""
" HTML5
""""""""""""""""""""
NeoBundle 'othree/html5.vim'

""""""""""""""""""""
" Jinja2
""""""""""""""""""""
autocmd BufNewFile,BufRead *.{jinja2,j2} set filetype=htmljinja
NeoBundleLazy 'https://github.com/estin/htmljinja.git', {
    \ 'autoload': {
    \     'filetypes': ['htmljinja']
    \ }}

""""""""""""""""""""
" Mako
""""""""""""""""""""
autocmd BufNewFile,BufRead *.mak set filetype=mako
NeoBundleLazy 'mako.vim', {
    \ 'autoload': {
    \     'filetypes': ['mako']
    \ }}

""""""""""""""""""""
" Markdown
""""""""""""""""""""
autocmd BufNewFile,BufRead *.{md,mdwn,mkd,mkdn,mark*} set filetype=markdown
let g:markdown_fenced_languages = [
    \ 'css',
    \ 'coffee',
    \ 'erb=eruby.html',
    \ 'go',
    \ 'html',
    \ 'javascript',
    \ 'js=javascript',
    \ 'json=javascript',
    \ 'proto',
    \ 'python',
    \ 'ruby',
    \ 'sass',
    \ 'sh',
    \ 'xml',
    \ ]

""""""""""""""""""""
" Protocol Buffers
""""""""""""""""""""
autocmd BufNewFile,BufRead *.proto setfiletype proto
NeoBundleLazy 'uarun/vim-protobuf', {
    \ 'autoload': {
    \     'filetypes': ['proto', 'markdown']
    \ }}

""""""""""""""""""""
" Python
""""""""""""""""""""
NeoBundleLazy 'davidhalter/jedi-vim', {
    \ 'autoload': {
    \     'filetypes': ['python', 'python3'],
    \ }}

let s:bundle = neobundle#get('jedi-vim')
function! s:bundle.hooks.on_source(bundle)
    let g:jedi#auto_initialization = 1
    let g:jedi#auto_vim_configuration = 0
    let g:jedi#popup_on_dot = 0
    let g:jedi#rename_command = '<Leader>R'
endfunction
unlet s:bundle

autocmd FileType python let b:did_ftplugin = 1

NeoBundleLazy 'python.vim', {
    \ 'autoload': {
    \     'filetypes': ['python', 'python3']
    \ }}

NeoBundleLazy 'jmcantrell/vim-virtualenv', {
    \ 'autoload': {
    \     'filetypes': ['python', 'python3']
    \ }}

""""""""""""""""""""
" Scala
""""""""""""""""""""
autocmd BufNewFile,BufRead *.{scala,sbt} set filetype=scala
NeoBundleLazy 'derekwyatt/vim-scala', {
    \ 'autoload': {
    \     'filetypes': ['scala'],
    \ }}

""""""""""""""""""""
" neobundle.vim
""""""""""""""""""""
call neobundle#end()
NeoBundleCheck

filetype plugin indent on

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

"Mouse
set mouse= " Disable mouse
