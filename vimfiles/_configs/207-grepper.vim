UsePlugin 'vim-grepper'

let g:grepper = {
      \ 'tools': ['rg', 'ag', 'git'],
      \ }

nnoremap <leader>g <cmd>Grepper -noopen -quickfix -noswitch<cr>
nnoremap <leader>* <cmd>Grepper -noopen -quickfix -noswitch -cword -noprompt<cr>

if FindPlugin('ctrlp.vim')
  augroup on_grepper_finished
    autocmd!
    autocmd User Grepper execute 'CtrlPQuickfix'
  augroup END
endif
