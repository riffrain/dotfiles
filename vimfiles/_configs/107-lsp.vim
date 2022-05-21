UsePlugin 'nvim-lspconfig'

lua <<EOF

-- local saga = require 'lspsaga'
-- saga.init_lsp_saga {
--   debug = false,
--   use_saga_diagnostic_sign = true,
--   -- diagnostic sign
--   error_sign = ">",
--   warn_sign = "_",
--   hint_sign = "",
--   infor_sign = "?",
--   diagnostic_header_icon = "",
--   -- code action title icon
--   code_action_icon = " ",
--   code_action_prompt = {
--     enable = true,
--     sign = true,
--     sign_priority = 40,
--     virtual_text = true,
--   },
--   finder_definition_icon = "",
--   finder_reference_icon = "",
--   max_preview_lines = 10,
--   finder_action_keys = {
--     open = "o",
--     vsplit = "s",
--     split = "i",
--     quit = "q",
--     scroll_down = "<C-f>",
--     scroll_up = "<C-b>",
--   },
--   code_action_keys = {
--     quit = "q",
--     exec = "<CR>",
--   },
--   rename_action_keys = {
--     quit = "<C-c>",
--     exec = "<CR>",
--   },
--   definition_preview_icon = "",
--   border_style = "single",
--   rename_prompt_prefix = ">",
--   rename_output_qflist = {
--     enable = false,
--     auto_open_qflist = false,
--   },
--   server_filetype_map = {},
--   diagnostic_prefix_format = "%d. ",
--   diagnostic_message_format = "%m %c",
--   highlight_prefix = false,
-- }

  local on_attach = function(client, bufnr)
    local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end

    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

    --- In lsp attach function
    -- buf_set_keymap("n", "gr", "<cmd>Lspsaga rename<cr>", {silent = true, noremap = true})
    -- buf_set_keymap("n", "gx", "<cmd>Lspsaga code_action<cr>", {silent = true, noremap = true})
    -- buf_set_keymap("x", "gx", ":<c-u>Lspsaga range_code_action<cr>", {silent = true, noremap = true})
    -- buf_set_keymap("n", "K",  "<cmd>Lspsaga hover_doc<cr>", {silent = true, noremap = true})
    -- buf_set_keymap("n", "go", "<cmd>Lspsaga show_line_diagnostics<cr>", {silent = true, noremap = true})
    -- buf_set_keymap("n", "gj", "<cmd>Lspsaga diagnostic_jump_next<cr>", {silent = true, noremap = true})
    -- buf_set_keymap("n", "gk", "<cmd>Lspsaga diagnostic_jump_prev<cr>", {silent = true, noremap = true})
    -- buf_set_keymap("n", "<C-u>", "<cmd>lua require('lspsaga.action').smart_scroll_with_saga(-1, '<c-u>')<cr>", {})
    -- buf_set_keymap("n", "<C-d>", "<cmd>lua require('lspsaga.action').smart_scroll_with_saga(1, '<c-d>')<cr>", {})
    -- buf_set_keymap("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", { silent = true, noremap = true })
    -- buf_set_keymap("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", { silent = true, noremap = true })

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
    -- buf_set_keymap("n", "<space>q", "<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>", opts)
    -- buf_set_keymap("n", "<space>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
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
          ["code_transform.import_globals"] = true,
          ["language_server_code_transform.import_globals"] = true,
          ["language_server_code_transform.import_name.report_non_existing_names"] = true
        }
      end

      opts.on_attach = on_attach
      -- opts.capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
      server:setup(opts)
      vim.cmd([[
        do User LspAttachBuffers
      ]])
  end)

EOF
