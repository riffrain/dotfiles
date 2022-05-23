UsePlugin 'nvim-treesitter'

lua <<EOF
  require'nvim-treesitter.configs'.setup {
    ensure_installed = {
      'bash', 'comment', 'css', 'dockerfile', 'help',
      'html', 'javascript', 'jsdoc', 'json', 'lua', 'php',
      'scss', 'tsx', 'typescript', 'vim', 'vue',
      'yaml',
    },
    sync_install = false,
    highlight = {
      enable = true,
      additional_vim_regex_highlighting = true,
    },
    indent = {
      enable = false,
    },
    rainbow = {
      enable = true,
      extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
      max_file_lines = nil, -- Do not enable for files with more than n lines, int
    }
  }
EOF
