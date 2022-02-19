"
" unlimited undo
"
if has('persistent_undo')
    let s:undo_dir = '~/.cache/vimundo'
    if !isdirectory(s:undo_dir)
      cal system('mkdir -p ' . shellescape(s:undo_dir))
    en
    se undodir=~/.cache/vimundo
    se undofile
en
