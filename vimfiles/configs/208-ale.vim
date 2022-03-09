UsePlugin 'ale'

let g:airline#extensions#ale#enabled = 1
let g:ale_sign_column_always = 1
let g:ale_fix_on_save = 1
let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_insert_leave = 0
let g:ale_lint_on_enter = 0
let g:ale_set_balloons = 1
let g:ale_set_hover_to_preview = 1
let g:ale_float_preview = 1


nmap <Leader>[g <Cmd>ALEPrevious<CR>
nmap <Leader>]g <Cmd>ALENext<CR>

