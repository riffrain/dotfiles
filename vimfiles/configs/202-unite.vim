"
" unite.vim
"
if empty(globpath(&rtp, 'plugged/unite.vim'))
  || empty(globpath(&rtp, 'plugged/vimproc.vim'))
  finish
endif
if !exists(':Unite')
  finish
endif

let g:unite_enable_start_insert = 1
let g:unite_enable_ignore_case = 1
let g:unite_enable_smart_case = 1

if executable('ag')
  let g:unite_source_grep_command = 'ag'
  let g:unite_source_grep_default_opts = '--nogroup --nocolor --column'
  let g:unite_source_grep_recursive_opt = ''
endif

nn <silent> <Leader>g :<C-u>Unite grep:. -buffer-name=search-buffer<CR>
nn <silent> <Leader>c :<C-u>Unite grep:. -buffer-name=search-buffer<CR><C-R><C-W>
nn <silent> <Leader>r :<C-u>UniteResume search-buffer<CR>
nn <silent> <Leader>b :<C-u>Unite buffer<CR>
nn <silent> <Leader>m :<C-u>Unite mark<CR>
nn <silent> <Leader>l :<C-u>Unite line<CR>
