setlocal tabstop=2
setlocal shiftwidth=2

if exists('b:ale_fixers')
  let b:ale_fixers += ['prettier', 'biome']
else
  let b:ale_fixers = ['prettier', 'biome']
endif
