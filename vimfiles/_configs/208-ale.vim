UsePlugin 'ale'

let g:ale_enabled = 0
let g:ale_sign_column_always = 1
let g:ale_fix_on_save = 0
let g:ale_lint_on_save = 1
let g:ale_lint_on_enter = 0
let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_insert_leave = 0
let g:ale_set_balloons = 1
let g:ale_hover_cursor = 0
let g:ale_hover_to_preview = 0
let g:ale_detail_to_floating_preview = 1
let g:ale_float_preview = 1
let g:ale_floating_window_border = ['│', '─', '╭', '╮', '╯', '╰']

function! s:init_ale()
  let b:ale_enabled = 1

  nmap <buffer> <Leader>K <plug>(ale_detail)
  nmap <buffer> <Leader>[g <plug>(ale_previous)
  nmap <buffer> <Leader>]g <plug>(ale_next)
endfunction

augroup ale_enable
  autocmd!
  autocmd BufEnter *.js,*.vue,*.php,*.ctp,*.sh call s:init_ale()
augroup END
