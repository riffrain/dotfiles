UsePlugin 'vim-grepper'

let g:grepper = {}
let g:grepper.switch = 1

nnoremap <leader>g <cmd>Grepper<cr>
nnoremap <leader>* <cmd>Grepper -cword<cr>
