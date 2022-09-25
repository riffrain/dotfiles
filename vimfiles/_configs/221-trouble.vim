UsePlugin 'trouble.nvim'

lua << EOF
  require("trouble").setup {
    mode = "document_diagnostics",
    icons = false,
    fold_open = "v", -- icon used for open folds
    fold_closed = ">", -- icon used for closed folds
    indent_lines = false, -- add an indent guide below the fold icons
    signs = {
        -- icons / text used for a diagnostic
        error = "error",
        warning = "warn",
        hint = "hint",
        information = "info"
    },
  }
EOF

nnoremap <leader>xx <cmd>TroubleToggle<cr>
