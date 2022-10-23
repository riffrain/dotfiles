UsePlugin 'mason.nvim'

lua <<EOF
  -- vim.cmd [[autocmd! ColorScheme * highlight NormalFloat guibg=#1f2335]]
  -- vim.cmd [[autocmd! ColorScheme * highlight FloatBorder guifg=white guibg=#1f2335]]

  local border = {'╭', '─', '╮', '│', '╯', '─', '╰', '│'}

  local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview

  function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
    opts = opts or {}
    opts.border = opts.border or border
    return orig_util_open_floating_preview(contents, syntax, opts, ...)
  end

  local on_attach = function(client, bufnr)
    local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end

    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

    local opts = { noremap=true, silent=true }
    buf_set_keymap("n", "gD", vim.lsp.buf.declaration, opts)
    buf_set_keymap("n", "gd", vim.lsp.buf.definition, opts)
    buf_set_keymap("n", "K", vim.lsp.buf.hover, opts)
    buf_set_keymap("n", "gi", vim.lsp.buf.implementation, opts)
    -- buf_set_keymap("n", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
    -- buf_set_keymap("n", "<space>wa", "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>", opts)
    -- buf_set_keymap("n", "<space>wr", "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>", opts)
    -- buf_set_keymap("n", "<space>wl", "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>", opts)
    buf_set_keymap("n", "<space>D", vim.lsp.buf.type_definition, opts)
    buf_set_keymap("n", "<space>rn", vim.lsp.buf.rename, opts)
    buf_set_keymap("n", "<space>ca", vim.lsp.buf.code_action, opts)
    buf_set_keymap("n", "gr", vim.lsp.buf.references, opts)
    -- buf_set_keymap("n", "<space>e", "<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>", opts)
    buf_set_keymap("n", "[d", vim.lsp.diagnostic.goto_prev, opts)
    buf_set_keymap("n", "]d", vim.lsp.diagnostic.goto_next, opts)
    buf_set_keymap("n", "<space>q", vim.lsp.diagnostic.set_loclist, opts)
    buf_set_keymap("n", "<space>bf", vim.lsp.buf.formatting, opts)
  end

  -- Setup LSP
  require('mason').setup({})
  local nvim_lsp = require('lspconfig')
  local mason_lspconfig = require('mason-lspconfig')
  mason_lspconfig.setup_handlers({ function(server_name)
    local opts = {}
    if server_name == 'tsserver' then
      -- opts.init_options = {
      --   maxTsServerMemory = 256,
      -- }
    end

    if server_name == 'intelephense' then
      -- https://github.com/bmewburn/intelephense-docs/blob/master/installation.md
      -- opts.settings = {
      --   intelephense = {
      --     maxMemory = 256,
      --     diagnostics = {
      --       enable = true,
      --       run = 'onSave',
      --       unusedSymbols = true,
      --     },
      --     format = {
      --       enable = false,
      --     },
      --     files = {
      --       maxSize = 1000000,
      --     },
      --     completion = {
      --       insertUseDeclaration = true,
      --       maxItems = 15,
      --     },
      --     compatibility = {
      --       correctForBaseClassStaticUnionTypes = false,
      --       correctForArrayAccessArrayAndTraversableArrayUnionTypes = false,
      --     },
      --   },
      -- }
    end

    if server_name == 'phpactor' then
      opts.init_options = {
        ["indexer.enabled_watchers"] = { 'watchman', 'find' },
        ["code_transform.import_globals"] = true,
        ["language_server_code_transform.import_globals"] = true,
        ["language_server_code_transform.import_name.report_non_existing_names"] = true,
        ["completion_worse.experimantal"] = true,
      }
    end

    opts.on_attach = on_attach
    opts.capabilities = require('cmp_nvim_lsp').default_capabilities()
    nvim_lsp[server_name].setup(opts)
    vim.cmd([[
      do User LspAttachBuffers
    ]])
  end });
EOF
