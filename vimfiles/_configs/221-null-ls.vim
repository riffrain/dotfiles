UsePlugin 'null-ls.nvim'

lua <<EOF
local null_ls = require("null-ls")

null_ls.setup({
    sources = {
        null_ls.builtins.diagnostics.eslint,
        null_ls.builtins.diagnostics.phpcs,
        null_ls.builtins.diagnostics.phpmd,
    },
})
EOF
