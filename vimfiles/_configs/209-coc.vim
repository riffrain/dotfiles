UsePlugin 'coc.nvim'

" let g:coc_global_extensions = ['coc-html', 'coc-tsserver', 'coc-json', 'coc-css', 'coc-phpls', 'coc-vetur']

nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gt <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> fr <Plug>(coc-references)
nmap <silent> K <cmd>call CocAction('doHover')<CR>
