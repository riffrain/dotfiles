UsePlugin 'nvim_context_vt'

lua <<EOF
  require'nvim_context_vt'.setup{
    enabled = true,
    disable_virtual_lines_ft = { 'yaml' },
  }
EOF
