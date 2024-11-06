if exists("did_load_filetypes")
  finish
endif

augroup filetypedetect
  au BufNewFile,BufRead *.abnf,*.bnf setfiletype abnf
  au BufNewFile,BufRead *.as setfiletype actionscript
  au BufNewFile,BufRead .clang-format setfiletype yaml
  au BufNewFile,BufRead *.diag setfiletype diag
  au BufNewFile,BufRead go.mod setfiletype gomod
  " jinja2 bundled with ansible-vim
  au BufNewFile,BufRead *.j2 setfiletype jinja2
  au BufNewFile,BufRead *.jinja2,*.njk setfiletype html.jinja2
augroup END
