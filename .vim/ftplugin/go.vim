setlocal noexpandtab
setlocal tabstop=4
setlocal shiftwidth=4

let b:ale_fixers = ['gofmt', 'goimports']
let b:ale_linters = ['gofmt', 'govet']
let b:ale_go_gofmt_options = '-s'
