UsePlugin 'vim-startify'

let g:startify_custom_header = [
      \ '',
      \ '------------------------------------------------------------',
      \ '',
      \ '         Hostname: ' . trim(system('hostname')),
      \ '',
      \ '------------------------------------------------------------',
      \ ]
