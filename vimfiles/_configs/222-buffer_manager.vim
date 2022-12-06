UsePlugin 'buffer_manager.nvim'

lua <<EOF

vim.keymap.set({ 't', 'n' }, '<M-Space>', require("buffer_manager.ui").toggle_quick_menu, {noremap = true})

EOF
