let s:file = expand('%')

let b:ale_fixers = []
if s:file =~ '\.tf$'
  call add(b:ale_fixers, 'terraform')
elseif  s:file =~ '\.pkr\.hcl$'
  call add(b:ale_fixers, 'packer')
endif
