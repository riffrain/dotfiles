local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
end

vim.cmd [[packadd packer.nvim]]
vim.cmd[[autocmd BufWritePost plugins.lua PackerCompile]]

-- -- NvimTree
-- vim.cmd([[
--   let g:nvim_tree_disable_window_picker = 0
--   let g:nvim_tree_window_picker_chars = "sdfghjkl"
--   " nn <Leader>e <cmd>NvimTreeToggle<CR>
-- ]])

-- CtrlP
vim.cmd([[
  if executable('ag')
    let g:ctrlp_use_caching=0
    let g:ctrlp_user_command='ag %s -i -s --nocolor --nogroup -g ""'
  en
  let g:ctrlp_show_hidden = 1
  nn <Leader>f <cmd>CtrlP<CR>
  nn <Leader>l <cmd>CtrlPLine<CR>
  nn <Leader>b <cmd>CtrlPBuffer<CR>
]])

vim.cmd([[
  nn <Leader>t <cmd>Telescope find_files<CR>
]])

return require('packer').startup(function()
  use 'wbthomason/packer.nvim'

  use 'editorconfig/editorconfig-vim'

  use 'cohama/lexima.vim'

  use 'tpope/vim-surround'

  use 'wellle/targets.vim'

  use 'easymotion/vim-easymotion'

  use 'ctrlpvim/ctrlp.vim'

  use {
    't9md/vim-choosewin',
    config = function ()
      vim.cmd[[let g:choosewin_label='sdfghjkl']]
    end
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

  use 'neovim/nvim-lspconfig'
  use {
    'hrsh7th/cmp-nvim-lsp',
    requires = {
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-cmdline',
      'hrsh7th/nvim-cmp',
    },
  }

  -- use {
  --   'kyazdani42/nvim-tree.lua',
  --   requires = {
  --     'kyazdani42/nvim-web-devicons',
  --   },
  --   config = function()
  --     require'nvim-tree'.setup {
  --       disable_netrw       = false,
  --       hijack_netrw        = false,
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
  --   end
  -- }

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
    'nvim-telescope/telescope.nvim',
    requires = {
      'nvim-lua/plenary.nvim',
    }
  }

  use 'prabirshrestha/vim-lsp'
  use 'mattn/vim-lsp-settings'
  use 'prabirshrestha/asyncomplete.vim'
  use 'prabirshrestha/asyncomplete-lsp.vim'

  use 'jremmen/vim-ripgrep'

  if packer_bootstrap then
    require('packer').sync()
  end
end)
