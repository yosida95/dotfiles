setlocal noexpandtab
setlocal tabstop=4
setlocal shiftwidth=4

let b:ale_fixers = ['goimports']
let b:ale_linters = ['govet', 'staticcheck']
