UsePlug 'lualine.nvim'

lua <<EOF
require('lualine').setup({
  -- component_separators = { left = '', right = ''},
  -- section_separators = { left = '', right = ''},
  options = {
    icons_enabled = false,
    component_separators = { left = '|', right = '|'},
    section_separators = { left = '', right = ''},
  },
})
EOF
