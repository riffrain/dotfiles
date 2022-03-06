UsePlugin 'vim-grepper'

let g:grepper = {}
let g:grepper.switch = 1
let g:grepper.quickfix = 0

nnoremap <leader>g <cmd>Grepper<cr>
nnoremap <leader>* <cmd>Grepper -cword<cr>
