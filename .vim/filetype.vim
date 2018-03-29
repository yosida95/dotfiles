if exists('did_load_filetypes')
    finish
endif

augroup filetypedetect
    autocmd!
    " ABNF
    autocmd BufNewFile,BufRead *.abnf,*.bnf setfiletype abnf
    " Jinja2
    autocmd BufNewFile,BufRead *.{jinja2,j2} setfiletype htmljinja
    " Mako
    autocmd BufNewFile,BufRead *.mak setfiletype mako
    " Markdown
    autocmd BufNewFile,BufRead *.{md,mdwn,mkd,mkdn,mark*} setfiletype markdown
    " Gradle
    autocmd BufNewFile,BufRead *.gradle setfiletype groovy
    " YAML
    autocmd BufNewFile,BufRead .clang-format setfiletype yaml
augroup END
