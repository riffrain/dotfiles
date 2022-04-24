UsePlugin 'nvim-cmp'
UsePlugin 'nvim-lspconfig'
UsePlugin 'cmp-nvim-lsp'
UsePlugin 'cmp-buffer'
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
          calc     = '[C]',
          -- vsnip    = '[S]',
          buffer   = '[B]',
        })[entry.source.name]
        vim_item.dup = ({
          buffer = 0,
          path = 1,
          nvim_lsp = 0,
          -- vsnip = 0,
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
      { name = 'buffer',
        option = {
          get_bufnrs = function()
            local bufs = {}
            for _, win in ipairs(vim.api.nvim_list_wins()) do
              bufs[vim.api.nvim_win_get_buf(win)] = true
            end

            return vim.tbl_keys(bufs)
          end
        }
      },
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

      if server.name == 'phpactor' then
        opts.init_options = {
          ["core.min_memory_limit"] = 201326592,
          ["indexer.poll_time"] = 60000,
          ["indexer.buffer_time"] = 500,
          ["language_server_worse_reflection.workspace_index.update_interval"] = 1000,
          ["language_server_reference_reference_finder.reference_timeout"] = 3,
          ["language_server.enable_workspace"] = false,
          ["composer.enabled"] = true,
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

let s:timer = 0
autocmd TextChangedI * call s:on_text_changed()
function! s:on_text_changed() abort
  call timer_stop(s:timer)
  let s:timer = timer_start(200, function('s:complete'))
endfunction
function! s:complete(...) abort
  lua require('cmp').complete({ reason = require('cmp').ContextReason.Auto })
endfunction
