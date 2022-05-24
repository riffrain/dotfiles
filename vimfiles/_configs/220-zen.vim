UsePlugin 'zen-mode.nvim'

lua << EOF
  require("zen-mode").setup {
    window = {
      backdrop = 1,
      width = 128,
    },
    plugins = {
      options = {
        enabled = true,
        ruler = true,
        showcmd = true,
      },
      twilight = { enabled = true },
      gitsigns = { enabled = true },
    },
  }
EOF
