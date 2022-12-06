UsePlugin 'legendary.nvim'

lua <<EOF

require('legendary').setup({
  keymaps = {
    -- map keys to a command
    { '<leader>ff', ':Telescope find_files<CR>', description = 'Find files' },
  },
})

EOF
