UsePlugin 'hop.nvim'

nnoremap <Leader>hw <Cmd>HopWord<CR>
nnoremap <Leader>hl <Cmd>HopLine<CR>
nnoremap <Leader>hs <Cmd>HopLineStart<CR>
nnoremap <Leader>hp <Cmd>HopPattern<CR>

lua <<EOF
  require'hop'.setup()
EOF
