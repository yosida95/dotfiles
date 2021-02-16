if exists("did_load_filetypes")
  finish
endif

augroup filetypedetect
  autocmd! BufNewFile,BufRead *.abnf,*.bnf setfiletype abnf
  autocmd! BufNewFile,BufRead *.as setfiletype actionscript
  autocmd! BufNewFile,BufRead .clang-format setfiletype yaml
  autocmd! BufNewFile,BufRead *.diag setfiletype diag
  autocmd! BufNewFile,BufRead go.mod setfiletype gomod
  autocmd! BufNewFile,BufRead *.mak setfiletype mako
augroup END
