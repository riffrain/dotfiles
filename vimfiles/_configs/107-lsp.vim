UsePlugin 'nvim-lspconfig'

lua <<EOF
  local on_attach = function(client, bufnr)
    local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end

    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

    local opts = { noremap=true, silent=true }
    buf_set_keymap("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
    buf_set_keymap("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
    buf_set_keymap("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
    buf_set_keymap("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
    -- buf_set_keymap("n", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
    -- buf_set_keymap("n", "<space>wa", "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>", opts)
    -- buf_set_keymap("n", "<space>wr", "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>", opts)
    -- buf_set_keymap("n", "<space>wl", "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>", opts)
    buf_set_keymap("n", "<space>D", "<cmd>lua vim.lsp.buf.type_definition()<CR>", opts)
    buf_set_keymap("n", "<space>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
    buf_set_keymap("n", "<space>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
    buf_set_keymap("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
    -- buf_set_keymap("n", "<space>e", "<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>", opts)
    buf_set_keymap("n", "[d", "<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>", opts)
    buf_set_keymap("n", "]d", "<cmd>lua vim.lsp.diagnostic.goto_next()<CR>", opts)
    buf_set_keymap("n", "<space>q", "<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>", opts)
    buf_set_keymap("n", "<space>bf", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
  end

  -- Setup LSP
  local lsp_installer = require('nvim-lsp-installer')
  lsp_installer.on_server_ready(function(server)
      local opts = {}

      if server.name == 'tsserver' then
        -- opts.init_options = {
        --   maxTsServerMemory = 256,
        -- }
      end

      if server.name == 'intelephense' then
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

      if server.name == 'phpactor' then
        opts.init_options = {
          ["indexer.enabled_watchers"] = { 'watchman', 'find' },
          ["code_transform.import_globals"] = true,
          ["language_server_code_transform.import_globals"] = true,
          ["language_server_code_transform.import_name.report_non_existing_names"] = true
        }
      end

      opts.on_attach = on_attach
      opts.capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
      server:setup(opts)
      vim.cmd([[
        do User LspAttachBuffers
      ]])
  end)

EOF