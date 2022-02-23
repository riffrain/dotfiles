UsePlugin 'fzf'
UsePlugin 'fzf.vim'

let g:fzf_command_prefix = 'Fzf'

if executable('rg')
  noremap <leader>g <cmd>FzfRg<cr>
elseif executable('ag')
  noremap <leader>g <cmd>FzfAg<cr>
endif
