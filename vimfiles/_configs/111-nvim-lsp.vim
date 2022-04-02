UsePlugin 'nvim-cmp'
UsePlugin 'nvim-lspconfig'
UsePlugin 'cmp-nvim-lsp'
UsePlugin 'cmp-buffer'
UsePlugin 'cmp-path'
UsePlugin 'cmp-cmdline'
UsePlugin 'cmp-vsnip'
UsePlugin 'vim-vsnip'
UsePlugin 'nvim-lsp-installer'

set completeopt=menu,menuone,noselect

lua <<EOF
  local cmp = require'cmp'
  cmp.setup({
    snippet = {
      expand = function(args)
        vim.fn["vsnip#anonymous"](args.body)
      end,
    },
    formatting = {
      format = function(entry, vim_item)
        vim_item.menu = ({
          nvim_lsp = '[L]',
          emoji    = '[E]',
          path     = '[F]',
          calc     = '[C]',
          vsnip    = '[S]',
          buffer   = '[B]',
        })[entry.source.name]
        vim_item.dup = ({
          buffer = 1,
          path = 1,
          nvim_lsp = 0,
          vsnip = 0,
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
    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
      { name = 'vsnip' },
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

  -- Setup LSP
  local lsp_installer = require('nvim-lsp-installer')
  lsp_installer.on_server_ready(function(server)
      local opts = {}
      opts.capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
      server:setup(opts)
      vim.cmd([[
        do User LspAttachBuffers
      ]])
  end)
EOF
