local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
end

vim.cmd([[
packadd packer.nvim
au MyAutoGroup BufWritePost plugins.lua PackerCompile
au MyAutoGroup BufWritePost init.lua source <afile> | PackerCompile
]])

-- LSP
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
    underline = true,
    virtual_text = false,
    signs = true,
    update_in_insert = false,
  }
)
vim.api.nvim_set_keymap('n', 'gd', ':lua vim.diagnostic.open_float()<CR>',  {noremap = true, silent = true})
-- vim.g.diagnostics_active = true
-- function _G.toggle_diagnostics()
--   vim.diagnostic.hide()
--   if vim.g.diagnostics_active then
--     vim.g.diagnostics_active = false
--     vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
--       vim.lsp.diagnostic.on_publish_diagnostics, {
--         virtual_text = false,
--         signs = true,
--         underline = true,
--         update_in_insert = false,
--       }
--     )
--   else
--     vim.g.diagnostics_active = true
--     vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
--       vim.lsp.diagnostic.on_publish_diagnostics, {
--         virtual_text = true,
--         signs = true,
--         underline = true,
--         update_in_insert = false,
--       }
--     )
--   end
--   vim.diagnostic.show()
-- end

require('packer').startup(function()
  use 'wbthomason/packer.nvim'

  use 'editorconfig/editorconfig-vim'

  use 'cohama/lexima.vim'

  use 'tpope/vim-surround'

  use 'wellle/targets.vim'

  use 'easymotion/vim-easymotion'

  use {
    'mattn/vim-findroot',
    config = vim.cmd [[
      let g:findroot_not_for_subdir = 0
    ]]
  }

  use {
    'Mofiqul/vscode.nvim',
    config = function ()
      vim.cmd([[
        let g:vscode_style = "dark"
        let g:vscode_transparent = 1
        let g:vscode_italic_comment = 1
        try
          colorscheme vscode
        endtry
      ]])
    end
  }

  -- use 'jremmen/vim-ripgrep'

  use {
    'junegunn/fzf.vim',
    requires = {
      'junegunn/fzf',
    },
  }
  use 'ctrlpvim/ctrlp.vim'

  use 'skywind3000/asyncrun.vim'
  use {
    't9md/vim-choosewin',
    config = function ()
      vim.cmd[[let g:choosewin_label='sdfghjkl']]
    end
  }

  use {
    'nvim-lualine/lualine.nvim',
    requires = { 'kyazdani42/nvim-web-devicons', opt = true },
    config = function ()
      require('lualine').setup {
        options = {
          icons_enabled = true,
          theme = 'auto',
          component_separators = { left = '', right = ''},
          section_separators = { left = '', right = ''},
          disabled_filetypes = {},
          always_divide_middle = true,
        },
        sections = {
          lualine_a = {'mode'},
          lualine_b = {'branch', 'diff', 'diagnostics'},
          lualine_c = {'filename'},
          lualine_x = {'encoding', 'fileformat', 'filetype'},
          lualine_y = {'progress'},
          lualine_z = {'location'}
        },
        inactive_sections = {
          lualine_a = {},
          lualine_b = {},
          lualine_c = {'filename'},
          lualine_x = {'location'},
          lualine_y = {},
          lualine_z = {}
        },
        tabline = {},
        extensions = {}
      }
    end
  }

  use {
    'hrsh7th/nvim-cmp',
    requires = {
      'neovim/nvim-lspconfig',
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-cmdline',
      'hrsh7th/cmp-vsnip',
      'hrsh7th/vim-vsnip',
      'williamboman/nvim-lsp-installer',
    },
    config = function ()
      vim.cmd [[set completeopt=menu,menuone,noselect]]

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
    end
  }

  use {
    'kyazdani42/nvim-tree.lua',
    requires = {
      'kyazdani42/nvim-web-devicons',
    },
    config = function()
      require'nvim-tree'.setup {
        disable_netrw       = false,
        hijack_netrw        = false,
        open_on_setup       = false,
        ignore_ft_on_setup  = {},
        auto_close          = false,
        open_on_tab         = false,
        hijack_cursor       = false,
        update_cwd          = false,
        update_to_buf_dir   = {
          enable = true,
          auto_open = true,
        },
        diagnostics = {
          enable = false,
          icons = {
            hint = "",
            info = "",
            warning = "",
            error = "",
          }
        },
        update_focused_file = {
          enable      = false,
          update_cwd  = false,
          ignore_list = {}
        },
        system_open = {
          cmd  = nil,
          args = {}
        },
        filters = {
          dotfiles = false,
          custom = {}
        },
        git = {
          enable = true,
          ignore = true,
          timeout = 500,
        },
        view = {
          width = 30,
          height = 30,
          hide_root_folder = false,
          side = 'left',
          auto_resize = false,
          mappings = {
            custom_only = true,
            list = {
              { key = {'<CR>', 'l'}, action = 'edit' },
              { key = '<C-v>', action = 'vsplit' },
              { key = '<C-x>', action = 'split' },
              { key = '<C-t>', action = 'tabnew' },
              { key = '<', action = 'prev_sibling' },
              { key = '>', action = 'next_sibling' },
              { key = 'P', action = 'parent_node' },
              { key = 'h', action = 'close_node' },
              { key = 'K', action = 'first_sibling' },
              { key = 'J', action = 'last_sibling' },
              { key = 'I', action = 'toggle_ignored' },
              { key = '.', action = 'toggle_dotfiles' },
              { key = 'R', action = 'refresh' },
              { key = 'ma', action = 'create' },
              { key = 'md', action = 'remove' },
              { key = 'mm', action = 'rename' },
              { key = 'mx', action = 'cut' },
              { key = 'mp', action = 'paste' },
              { key = 'y', action = 'copy_name' },
              { key = 'Y', action = 'copy_path' },
              { key = 'gy', action = 'copy_absolute_path' },
              { key = 'u', action = 'dir_up' },
              { key = 'q', action = 'close' },
              { key = '?', action = 'toggle_help' },
            },
          },
          number = false,
          relativenumber = false,
          signcolumn = "yes"
        },
        trash = {
          cmd = nil,
          require_confirm = true
        }
      }
      vim.cmd([[
        let g:nvim_tree_disable_window_picker = 0
        let g:nvim_tree_window_picker_chars = "sdfghjkl"
        nn <Leader>e <cmd>NvimTreeToggle<CR>
      ]])
    end
  }

  use {
    'nvim-treesitter/nvim-treesitter',
    config = function ()
      require'nvim-treesitter.configs'.setup {
        ensure_installed = 'maintained',
        sync_install = true,
        highlight = {
          enable = true,
          additional_vim_regex_highlighting = true,
        },
        -- indent = {
        --   enable = true,
        -- },
      }
    end
  }

  if packer_bootstrap then
    require('packer').sync()
  end
end)
