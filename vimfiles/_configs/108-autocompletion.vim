UsePlugin 'nvim-cmp'

set completeopt=menu,menuone,noselect

let s:timer = 0
autocmd TextChangedI * call s:on_text_changed()
function! s:on_text_changed() abort
  call timer_stop(s:timer)
  let s:timer = timer_start(200, function('s:complete'))
endfunction
function! s:complete(...) abort
  lua require('cmp').complete({ reason = require('cmp').ContextReason.Auto })
endfunction

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
          -- omni     = '[O]',
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
EOF
