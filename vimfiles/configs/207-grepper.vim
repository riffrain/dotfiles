UsePlugin 'vim-grepper'

noremap <leader>g <cmd>Grepper<cr>

nnoremap <leader>* :Grepper -tool ag -cword -noprompt<cr>
