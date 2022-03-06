"
" unlimited undo
"
if has('persistent_undo')
    let s:undo_dir = expand('~/.cache/vimundo')
    if !isdirectory(s:undo_dir)
        call system('mkdir -p ' . shellescape(s:undo_dir))
    endif
    set undodir=~/.cache/vimundo
    set undofile
endif
