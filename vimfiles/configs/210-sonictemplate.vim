UsePlug 'vim-sonictemplate'

let g:sonictemplate_vim_template_dir = [
      \ expand('~/.vim/templates'),
      \ ]

inoremap <expr> <C-e><C-e> pumvisible()?'<c-y><c-e><plug>(sonictemplate-postfix)':'<plug>(sonictemplate-postfix)'
