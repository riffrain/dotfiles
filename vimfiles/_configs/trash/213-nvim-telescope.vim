if !has('nvim')
  finish
endif

UsePlugin 'plenary.nvim'
UsePlugin 'telescope.nvim'

nnoremap <Leader>f <cmd>Telescope find_files<CR>
nnoremap <Leader>b <cmd>Telescope buffers<CR>
nnoremap <Leader>l <cmd>Telescope current_buffer_fuzzy_find<CR>
