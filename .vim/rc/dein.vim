let s:dein_dir = expand('~/.cache/dein')
if !dein#load_state(s:dein_dir)
    finish
endif

call dein#begin(s:dein_dir, [expand('<sfile>')] + split(glob('~/.vim/rc/*.toml'), '\n'))

call dein#load_toml('~/.vim/rc/dein.toml', {'lazy': 0})
call dein#load_toml('~/.vim/rc/deinlazy.toml', {'lazy': 1})

call dein#end()
call dein#save_state()

if dein#check_install()
    call dein#install()
endif
