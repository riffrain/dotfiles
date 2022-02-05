local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
end

vim.cmd [[packadd packer.nvim]]
vim.cmd [[autocmd BufWritePost plugins.lua PackerCompile]]

require('packer').startup(function()
  use 'wbthomason/packer.nvim'

  use 'editorconfig/editorconfig-vim'

  use 'cohama/lexima.vim'

  use 'tpope/vim-surround'

  use 'wellle/targets.vim'

  use 'easymotion/vim-easymotion'

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
  use 'ctrlpvim/ctrlp.vim'

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
        mapping = {
          ['<C-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
          ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
          ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
          ['<C-y>'] = cmp.config.disable, -- Specify `cmp.config.disable` i you want to remove the default `<C-y>` mapping.
          ['<C-e>'] = cmp.mapping({
            i = cmp.mapping.abort(),
            c = cmp.mapping.close(),
          }),
          ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
        },
        sources = cmp.config.sources({
          { name = 'nvim_lsp' },
          { name = 'vsnip' },
        }, {
          { name = 'buffer' },
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
          vim.cmd [[ do User LspAttachBuffers ]]
      end)
    end
  }

  -- use {
  --   'Shougo/ddc.vim',
  --   requires = {
  --   'neovim/nvim-lspconfig',
  --   'williamboman/nvim-lsp-installer',
  --     'vim-denops/denops.vim',
  --     'Shougo/ddc-around',
  --     'Shougo/ddc-matcher_head',
  --     'Shougo/ddc-sorter_rank',
  --     'Shougo/ddc-nvim-lsp',
  --     'Shougo/pum.vim',
  --     'Shougo/ddc-converter_remove_overlap',
  --     'LumaKernel/ddc-file',
  --     'matsui54/ddc-buffer',
  --     'tani/ddc-fuzzy',
  --     'tani/ddc-onp',
  --     'Shougo/pum.vim',
  --   },
  --   config = function ()
  --     vim.cmd([[
  --       call ddc#custom#patch_global('sources', ['nvim-lsp', 'around', 'buffer', 'file'])
  --       call ddc#custom#patch_global('completionMenu', 'pum.vim')
  --       call ddc#custom#patch_global('sourceOptions', {
  --         \ '_': {
  --         \   'matchers': ['matcher_onp'],
  --         \   'converters': ['converter_onp'],
  --         \   'sorters': ['sorter_onp'] },
  --         \ 'nvim-lsp': {
  --         \   'mark': 'lsp',
  --         \   'forceCompletionPattern': '\.\w*|:\w*|->\w*' },
  --         \ 'file': { 'mark': 'file', 'isVolatile': v:true, 'forceCompletionPattern': '\S/\S*' },
  --         \ 'around': {'mark': 'around'},
  --         \ 'buffer': {'mark': 'buffer'},
  --         \ })
  --       call ddc#custom#patch_global('sourceParams', {
  --         \ 'buffer': {
  --         \   'requireSameFiletype': v:false,
  --         \   'limitBytes': 5000000,
  --         \   'fromAltBuf': v:true,
  --         \   'forceCollect': v:true,
  --         \ },
  --         \ })
  --       call ddc#custom#patch_global('filterParams', {
  --         \   'matcher_fuzzy': {
  --         \     'splitMode': 'character',
  --         \   }
  --         \ })

  --       call ddc#enable()

  --       " inoremap <silent><expr> <TAB>
  --       "       \ pum#visible() ? '<Cmd>call pum#map#insert_relative(+1)<CR>' :
  --       "       \ (col('.') <= 1 <Bar><Bar> getline('.')[col('.') - 2] =~# '\s') ?
  --       "       \ '<TAB>' : ddc#manual_complete()
  --       inoremap <S-Tab> <Cmd>call pum#map#insert_relative(-1)<CR>
  --       inoremap <C-n>   <Cmd>call pum#map#select_relative(+1)<CR>
  --       inoremap <C-p>   <Cmd>call pum#map#select_relative(-1)<CR>
  --       inoremap <C-y>   <Cmd>call pum#map#confirm()<CR>
  --       inoremap <C-e>   <Cmd>call pum#map#cancel()<CR>
  --       inoremap <silent><expr> <TAB> pum#visible() ? '<Cmd>call pum#map#confirm()<CR>' : '<TAB>'
  --     ]])
  --   end
  -- }

  -- use {
  --   't9md/vim-choosewin',
  --   config = function ()
  --     vim.cmd[[let g:choosewin_label='sdfghjkl']]
  --   end
  -- }

  use {
    'lambdalisue/fern.vim',
    requires = {
      'lambdalisue/nerdfont.vim',
      'lambdalisue/fern-hijack.vim',
      -- 'lambdalisue/fern-renderer-nerdfont.vim',
      'lambdalisue/fern-ssh',
    },
    config = function ()
      vim.cmd([[
        let g:fern#renderer = "nerdfont"
        nn <Leader>e <Cmd>Fern . -drawer -toggle<CR>
      ]])
    end
  }

  -- use {
  --   'kyazdani42/nvim-tree.lua',
  --   requires = {
  --     'kyazdani42/nvim-web-devicons',
  --   },
  --   config = function()
  --     require'nvim-tree'.setup {
  --       disable_netrw       = true,
  --       hijack_netrw        = true,
  --       open_on_setup       = false,
  --       ignore_ft_on_setup  = {},
  --       auto_close          = false,
  --       open_on_tab         = false,
  --       hijack_cursor       = false,
  --       update_cwd          = false,
  --       update_to_buf_dir   = {
  --         enable = true,
  --         auto_open = true,
  --       },
  --       diagnostics = {
  --         enable = false,
  --         icons = {
  --           hint = "",
  --           info = "",
  --           warning = "",
  --           error = "",
  --         }
  --       },
  --       update_focused_file = {
  --         enable      = false,
  --         update_cwd  = false,
  --         ignore_list = {}
  --       },
  --       system_open = {
  --         cmd  = nil,
  --         args = {}
  --       },
  --       filters = {
  --         dotfiles = false,
  --         custom = {}
  --       },
  --       git = {
  --         enable = true,
  --         ignore = true,
  --         timeout = 500,
  --       },
  --       view = {
  --         width = 30,
  --         height = 30,
  --         hide_root_folder = false,
  --         side = 'left',
  --         auto_resize = false,
  --         mappings = {
  --           custom_only = true,
  --           list = {
  --             { key = {'<CR>', 'l'}, action = 'edit' },
  --             { key = '<C-v>', action = 'vsplit' },
  --             { key = '<C-x>', action = 'split' },
  --             { key = '<C-t>', action = 'tabnew' },
  --             { key = '<', action = 'prev_sibling' },
  --             { key = '>', action = 'next_sibling' },
  --             { key = 'P', action = 'parent_node' },
  --             { key = 'h', action = 'close_node' },
  --             { key = 'K', action = 'first_sibling' },
  --             { key = 'J', action = 'last_sibling' },
  --             { key = 'I', action = 'toggle_ignored' },
  --             { key = '.', action = 'toggle_dotfiles' },
  --             { key = 'R', action = 'refresh' },
  --             { key = 'ma', action = 'create' },
  --             { key = 'md', action = 'remove' },
  --             { key = 'mm', action = 'rename' },
  --             { key = 'mx', action = 'cut' },
  --             { key = 'mp', action = 'paste' },
  --             { key = 'y', action = 'copy_name' },
  --             { key = 'Y', action = 'copy_path' },
  --             { key = 'gy', action = 'copy_absolute_path' },
  --             { key = 'u', action = 'dir_up' },
  --             { key = 'q', action = 'close' },
  --             { key = '?', action = 'toggle_help' },
  --           },
  --         },
  --         number = false,
  --         relativenumber = false,
  --         signcolumn = "yes"
  --       },
  --       trash = {
  --         cmd = nil,
  --         require_confirm = true
  --       }
  --     }
  --     vim.cmd([[
  --       let g:nvim_tree_disable_window_picker = 0
  --       let g:nvim_tree_window_picker_chars = "sdfghjkl"
  --       " nn <Leader>e <cmd>NvimTreeToggle<CR>
  --     ]])
  --   end
  -- }

  use {
    'nvim-telescope/telescope.nvim',
    requires = {
      'nvim-lua/plenary.nvim',
    },
    config = function ()
      vim.cmd([[
        nn <Leader>t <cmd>Telescope find_files<CR>
        nn <Leader>b <cmd>Telescope buffers<CR>
      ]])
    end
  }

  -- use 'jremmen/vim-ripgrep'

  use {
    'nvim-treesitter/nvim-treesitter',
    config = function ()
      vim.cmd [[TSUpdate]]
    end
  }

  if packer_bootstrap then
    require('packer').sync()
  end
end)

vim.cmd([[autocmd BufWritePost init.lua source <afile> | PackerCompile]])

-- CtrlP
-- vim.cmd([[
--   if executable('ag')
--     let g:ctrlp_use_caching=0
--     let g:ctrlp_user_command='ag %s -i -s --nocolor --nogroup -g ""'
--   en
--   let g:ctrlp_show_hidden = 1
--   nn <Leader>f <cmd>CtrlP<CR>
--   nn <Leader>l <cmd>CtrlPLine<CR>
--   nn <Leader>b <cmd>CtrlPBuffer<CR>
-- ]])

