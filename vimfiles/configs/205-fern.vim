UsePlugin 'fern.vim'

function! s:init_fern() abort
  setlocal nonumber
  nmap <buffer> <Plug>(fern-action-open) <Plug>(fern-action-open:select)
  " nmap <buffer> <Plug>(fern-action-expand) <Plug>(fern-action-open:stay)
endfunction

augroup MyFern
  au! *
  au FileType fern call s:init_fern()
augroup END

let g:fern#disable_default_mappings=0
let g:fern#internal#window#select_chars = split('sdfghjkl', '\zs')
nnoremap <leader>e <cmd>Fern . -drawer -toggle -width=40<CR>
