UsePlugin 'vim-cursorword'

let g:cursorword = 0

" Toggle cursorword
noremap <Leader>c :<C-u>:let g:cursorword=!g:cursorword<CR>
