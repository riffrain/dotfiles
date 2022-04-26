UsePlugin 'nvim-cmp'
UsePlugin 'nvim-lspconfig'
UsePlugin 'cmp-nvim-lsp'
UsePlugin 'cmp-path'
UsePlugin 'cmp-cmdline'
UsePlugin 'nvim-lsp-installer'
UsePlugin 'cmp-nvim-lsp-signature-help'

set completeopt=menu,menuone,noselect

lua <<EOF
  local has_words_before = function()
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
  end

  local cmp = require'cmp'
  cmp.setup({
    completion = {
      autocomplete = false
    },
    snippet = {
      expand = function(args)
        vim.fn["vsnip#anonymous"](args.body)
      end,
    },
    formatting = {
      format = function(entry, vim_item)
        vim_item.menu = ({
          nvim_lsp = '[L]',
          path     = '[F]',
          -- calc     = '[C]',
          vsnip    = '[S]',
        })[entry.source.name]
        vim_item.dup = ({
          nvim_lsp = 0,
          vsnip = 0,
          path = 1,
        })[entry.source.name] or 0
        return vim_item
      end
    },
    -- mapping = {
    --   ['<C-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
    --   ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
    --   ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
    --   ['<C-y>'] = cmp.config.disable, -- Specify `cmp.config.disable` i you want to remove the default `<C-y>` mapping.
    --   ['<C-e>'] = cmp.mapping({
    --     i = cmp.mapping.abort(),
    --     c = cmp.mapping.close(),
    --   }),
    --   ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    -- },
    mapping = {
      ["<Tab>"] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_next_item()
        elseif has_words_before() then
          cmp.complete()
        else
          fallback() -- The fallback function sends a already mapped key. In this case, it's probably `<Tab>`.
        end
      end, { "i", "s" }),
      ["<S-Tab>"] = cmp.mapping(function()
        if cmp.visible() then
          cmp.select_prev_item()
        end
      end, { "i", "s" }),
    },
    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
      { name = 'nvim_lsp_signature_help' },
      -- { name = 'vsnip' },
    })
  })
  -- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline('/', {
    sources = {
      { name = 'buffer' }
    }
  })
  -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline(':', {
    sources = cmp.config.sources({
      { name = 'path' }
    }, {
      { name = 'cmdline' }
    })
  })

  local on_attach = function(client, bufnr)
    local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end

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
        opts.init_options = {
          maxTsServerMemory = 256,
        }
      end

      if server.name == 'intelephense' then
        -- https://github.com/bmewburn/intelephense-docs/blob/master/installation.md
        opts.settings = {
          intelephense = {
            maxMemory = 256,
            diagnostics = {
              enable = true,
              run = 'onSave',
              unusedSymbols = true,
            },
            format = {
              enable = false,
            },
            files = {
              maxSize = 1000000,
            },
            completion = {
              insertUseDeclaration = true,
              maxItems = 15,
            },
            compatibility = {
              correctForBaseClassStaticUnionTypes = false,
              correctForArrayAccessArrayAndTraversableArrayUnionTypes = false,
            },
          },
        }
      end

      if server.name == 'phpactor' then
        -- https://phpactor.readthedocs.io/en/master/reference/configuration.html
        opts.init_options = {
          ["core.min_memory_limit"] = 10000, -- 201326592,
          ["indexer.poll_time"] = 60000,
          ["indexer.buffer_time"] = 500,
          ["language_server_worse_reflection.workspace_index.update_interval"] = 1000,
          ["language_server_reference_reference_finder.reference_timeout"] = 3,
          ["language_server.enable_workspace"] = true,
          ["language_server.file_events"] = false,
          ["language_server.diagnostics_on_save"] = true,
          ["language_server.diagnostics_on_update"] = false,
          ["composer.enable"] = true,
          ["indexer.exclude_patterns"] = {
            "/webroot/**/*",
            "/tmp/**/*",
            "/benchmarks/**/*",
            "/vendor/**/Tests/**/*",
            "/vendor/**/tests/**/*",
            "/vendor/**/Test/**/*",
            "/vendor/**/test/**/*",
            "/vendor/composer/**/*",
            "/vendor/deployer/**/*",
            "/.git/**/*",
            "/node_modules/**/*",
            "/vendor/**/vendor/**/*",
          },
          ["indexer.reference_finder.deep"] = false,
          ["indexer.implementation_finder.deep"] = false,
          ["completion.limit"] = 100,
          ["completion_worse.snippets"] = true,
          ["completion_worse.completor.class.limit"] = 10,
          ["completion_worse.completor.declared_class.enabled"] = false,
          ["completion_worse.completor.name_search.enabled"] = false,
          ["completion_worse.completor.class_alias.enabled"] = false,
          ["completion_worse.completor.constant.enabled"] = false,
          ["completion_worse.completor.scf_class.enabled"] = false,
          ["completion_worse.completor.declared_function.enabled"] = false,
          ["completion_worse.completor.local_variable.enabled"] = true,
          ["completion_worse.completor.constructor.enabled"] = false,
          ["completion_worse.completor.named_parameter.enabled"] = false,
          ["completion_worse.completor.worse_parameter.enabled"] = false,
          ["language_server_code_transform.import_globals"] = false,
          ["language_server_code_transform.import_name.report_non_existing_names"] = false,
          ["class_to_file.brute_force_conversion"] = false,
          ["core.warn_on_develop"] = false,
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

let s:timer = 0
autocmd TextChangedI * call s:on_text_changed()
function! s:on_text_changed() abort
  call timer_stop(s:timer)
  let s:timer = timer_start(200, function('s:complete'))
endfunction
function! s:complete(...) abort
  lua require('cmp').complete({ reason = require('cmp').ContextReason.Auto })
endfunction
