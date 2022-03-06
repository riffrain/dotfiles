UsePlugin 'vim-grepper'

nnoremap <leader>g <cmd>Grepper -noopen -quickfix -noswitch<cr>
nnoremap <leader>* <cmd>Grepper -noopen -quickfix -noswitch -cword<cr>

if FindPlugin('ctrlp.vim')
  augroup on_grepper_finished
    autocmd!
    autocmd User Grepper execute 'CtrlPQuickfix'
  augroup END
endif
