setlocal shiftwidth=2

if yosida95#HasNodeDependency('styled-components')
  let b:ale_linter_aliases = ['css', 'typescript', 'tsx']
  if yosida95#HasNodeDependency('postcss-styled-syntax')
    let b:ale_fixers = ['stylelint']
  endif
endif
