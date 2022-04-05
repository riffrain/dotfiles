UsePlugin 'nvim-treesitter'

lua <<EOF
  require'nvim-treesitter.configs'.setup {
    ensure_installed = 'maintained',
    sync_install = false,
    highlight = {
      enable = true,
      additional_vim_regex_highlighting = true,
    },
    -- indent = {
    --   enable = true,
    -- },
  }
EOF
