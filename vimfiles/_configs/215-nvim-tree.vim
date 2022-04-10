UsePlugin 'nvim-tree.lua'

let g:nvim_tree_show_icons = {
  \ 'git': 0,
  \ 'folders': 0,
  \ 'files': 0,
  \ 'folder_arrows': 1,
  \ }

lua <<EOF
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
      -- icons = {
      --   hint = "",
      --   info = "",
      --   warning = "",
      --   error = "",
      -- }
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
    nn <Leader>l <cmd>NvimTreeRefresh<CR>
  ]])
EOF

