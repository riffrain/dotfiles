-- Automatically generated packer.nvim plugin loader code

if vim.api.nvim_call_function('has', {'nvim-0.5'}) ~= 1 then
  vim.api.nvim_command('echohl WarningMsg | echom "Invalid Neovim version for packer.nvim! | echohl None"')
  return
end

vim.api.nvim_command('packadd packer.nvim')

local no_errors, error_msg = pcall(function()

  local time
  local profile_info
  local should_profile = false
  if should_profile then
    local hrtime = vim.loop.hrtime
    profile_info = {}
    time = function(chunk, start)
      if start then
        profile_info[chunk] = hrtime()
      else
        profile_info[chunk] = (hrtime() - profile_info[chunk]) / 1e6
      end
    end
  else
    time = function(chunk, start) end
  end
  
local function save_profiles(threshold)
  local sorted_times = {}
  for chunk_name, time_taken in pairs(profile_info) do
    sorted_times[#sorted_times + 1] = {chunk_name, time_taken}
  end
  table.sort(sorted_times, function(a, b) return a[2] > b[2] end)
  local results = {}
  for i, elem in ipairs(sorted_times) do
    if not threshold or threshold and elem[2] > threshold then
      results[i] = elem[1] .. ' took ' .. elem[2] .. 'ms'
    end
  end

  _G._packer = _G._packer or {}
  _G._packer.profile_output = results
end

time([[Luarocks path setup]], true)
local package_path_str = "/Users/yasuhiro/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?.lua;/Users/yasuhiro/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?/init.lua;/Users/yasuhiro/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?.lua;/Users/yasuhiro/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?/init.lua"
local install_cpath_pattern = "/Users/yasuhiro/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/lua/5.1/?.so"
if not string.find(package.path, package_path_str, 1, true) then
  package.path = package.path .. ';' .. package_path_str
end

if not string.find(package.cpath, install_cpath_pattern, 1, true) then
  package.cpath = package.cpath .. ';' .. install_cpath_pattern
end

time([[Luarocks path setup]], false)
time([[try_loadstring definition]], true)
local function try_loadstring(s, component, name)
  local success, result = pcall(loadstring(s), name, _G.packer_plugins[name])
  if not success then
    vim.schedule(function()
      vim.api.nvim_notify('packer.nvim: Error running ' .. component .. ' for ' .. name .. ': ' .. result, vim.log.levels.ERROR, {})
    end)
  end
  return result
end

time([[try_loadstring definition]], false)
time([[Defining packer_plugins]], true)
_G.packer_plugins = {
  ["cmp-buffer"] = {
    loaded = true,
    path = "/Users/yasuhiro/.local/share/nvim/site/pack/packer/start/cmp-buffer",
    url = "https://github.com/hrsh7th/cmp-buffer"
  },
  ["cmp-cmdline"] = {
    loaded = true,
    path = "/Users/yasuhiro/.local/share/nvim/site/pack/packer/start/cmp-cmdline",
    url = "https://github.com/hrsh7th/cmp-cmdline"
  },
  ["cmp-nvim-lsp"] = {
    loaded = true,
    path = "/Users/yasuhiro/.local/share/nvim/site/pack/packer/start/cmp-nvim-lsp",
    url = "https://github.com/hrsh7th/cmp-nvim-lsp"
  },
  ["cmp-path"] = {
    loaded = true,
    path = "/Users/yasuhiro/.local/share/nvim/site/pack/packer/start/cmp-path",
    url = "https://github.com/hrsh7th/cmp-path"
  },
  ["ctrlp.vim"] = {
    loaded = true,
    path = "/Users/yasuhiro/.local/share/nvim/site/pack/packer/start/ctrlp.vim",
    url = "https://github.com/ctrlpvim/ctrlp.vim"
  },
  ["editorconfig-vim"] = {
    loaded = true,
    path = "/Users/yasuhiro/.local/share/nvim/site/pack/packer/start/editorconfig-vim",
    url = "https://github.com/editorconfig/editorconfig-vim"
  },
  ["lexima.vim"] = {
    loaded = true,
    path = "/Users/yasuhiro/.local/share/nvim/site/pack/packer/start/lexima.vim",
    url = "https://github.com/cohama/lexima.vim"
  },
  ["lualine.nvim"] = {
    config = { "\27LJ\2\n�\4\0\0\5\0\31\0/6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\t\0005\3\3\0005\4\4\0=\4\5\0035\4\6\0=\4\a\0034\4\0\0=\4\b\3=\3\n\0025\3\f\0005\4\v\0=\4\r\0035\4\14\0=\4\15\0035\4\16\0=\4\17\0035\4\18\0=\4\19\0035\4\20\0=\4\21\0035\4\22\0=\4\23\3=\3\24\0025\3\25\0004\4\0\0=\4\r\0034\4\0\0=\4\15\0035\4\26\0=\4\17\0035\4\27\0=\4\19\0034\4\0\0=\4\21\0034\4\0\0=\4\23\3=\3\28\0024\3\0\0=\3\29\0024\3\0\0=\3\30\2B\0\2\1K\0\1\0\15extensions\ftabline\22inactive_sections\1\2\0\0\rlocation\1\2\0\0\rfilename\1\0\0\rsections\14lualine_z\1\2\0\0\rlocation\14lualine_y\1\2\0\0\rprogress\14lualine_x\1\4\0\0\rencoding\15fileformat\rfiletype\14lualine_c\1\2\0\0\rfilename\14lualine_b\1\4\0\0\vbranch\tdiff\16diagnostics\14lualine_a\1\0\0\1\2\0\0\tmode\foptions\1\0\0\23disabled_filetypes\23section_separators\1\0\2\nright\b\tleft\b\25component_separators\1\0\2\nright\b\tleft\b\1\0\3\ntheme\tauto\18icons_enabled\2\25always_divide_middle\2\nsetup\flualine\frequire\0" },
    loaded = true,
    path = "/Users/yasuhiro/.local/share/nvim/site/pack/packer/start/lualine.nvim",
    url = "https://github.com/nvim-lualine/lualine.nvim"
  },
  ["nvim-cmp"] = {
    loaded = true,
    path = "/Users/yasuhiro/.local/share/nvim/site/pack/packer/start/nvim-cmp",
    url = "https://github.com/hrsh7th/nvim-cmp"
  },
  ["nvim-lspconfig"] = {
    loaded = true,
    path = "/Users/yasuhiro/.local/share/nvim/site/pack/packer/start/nvim-lspconfig",
    url = "https://github.com/neovim/nvim-lspconfig"
  },
  ["nvim-tree.lua"] = {
    config = { "\27LJ\2\n�\f\0\0\b\0007\0W6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0004\3\0\0=\3\4\0025\3\5\0=\3\6\0025\3\a\0005\4\b\0=\4\t\3=\3\n\0025\3\v\0004\4\0\0=\4\f\3=\3\r\0025\3\14\0004\4\0\0=\4\15\3=\3\16\0025\3\17\0004\4\0\0=\4\18\3=\3\19\0025\3\20\0=\3\21\0025\3\22\0005\4\23\0004\5\25\0005\6\25\0005\a\24\0=\a\26\6>\6\1\0055\6\27\0>\6\2\0055\6\28\0>\6\3\0055\6\29\0>\6\4\0055\6\30\0>\6\5\0055\6\31\0>\6\6\0055\6 \0>\6\a\0055\6!\0>\6\b\0055\6\"\0>\6\t\0055\6#\0>\6\n\0055\6$\0>\6\v\0055\6%\0>\6\f\0055\6&\0>\6\r\0055\6'\0>\6\14\0055\6(\0>\6\15\0055\6)\0>\6\16\0055\6*\0>\6\17\0055\6+\0>\6\18\0055\6,\0>\6\19\0055\6-\0>\6\20\0055\6.\0>\6\21\0055\6/\0>\6\22\0055\0060\0>\6\23\0055\0061\0>\6\24\5=\0052\4=\0043\3=\0034\0025\0035\0=\0036\2B\0\2\1K\0\1\0\ntrash\1\0\1\20require_confirm\2\tview\rmappings\tlist\1\0\2\vaction\16toggle_help\bkey\6?\1\0\2\vaction\nclose\bkey\6q\1\0\2\vaction\vdir_up\bkey\6u\1\0\2\vaction\23copy_absolute_path\bkey\agy\1\0\2\vaction\14copy_path\bkey\6Y\1\0\2\vaction\14copy_name\bkey\6y\1\0\2\vaction\npaste\bkey\amp\1\0\2\vaction\bcut\bkey\amx\1\0\2\vaction\vrename\bkey\amm\1\0\2\vaction\vremove\bkey\amd\1\0\2\vaction\vcreate\bkey\ama\1\0\2\vaction\frefresh\bkey\6R\1\0\2\vaction\20toggle_dotfiles\bkey\6.\1\0\2\vaction\19toggle_ignored\bkey\6I\1\0\2\vaction\17last_sibling\bkey\6J\1\0\2\vaction\18first_sibling\bkey\6K\1\0\2\vaction\15close_node\bkey\6h\1\0\2\vaction\16parent_node\bkey\6P\1\0\2\vaction\17next_sibling\bkey\6>\1\0\2\vaction\17prev_sibling\bkey\6<\1\0\2\vaction\vtabnew\bkey\n<C-t>\1\0\2\vaction\nsplit\bkey\n<C-x>\1\0\2\vaction\vvsplit\bkey\n<C-v>\bkey\1\0\1\vaction\tedit\1\3\0\0\t<CR>\6l\1\0\1\16custom_only\2\1\0\b\15signcolumn\byes\nwidth\3\30\16auto_resize\1\19relativenumber\1\tside\tleft\21hide_root_folder\1\vheight\3\30\vnumber\1\bgit\1\0\3\vignore\2\ftimeout\3�\3\venable\2\ffilters\vcustom\1\0\1\rdotfiles\1\16system_open\targs\1\0\0\24update_focused_file\16ignore_list\1\0\2\15update_cwd\1\venable\1\16diagnostics\nicons\1\0\4\fwarning\b\tinfo\b\nerror\b\thint\b\1\0\1\venable\1\22update_to_buf_dir\1\0\2\14auto_open\2\venable\2\23ignore_ft_on_setup\1\0\a\15update_cwd\1\18hijack_cursor\1\16open_on_tab\1\15auto_close\1\18open_on_setup\1\17hijack_netrw\2\18disable_netrw\2\nsetup\14nvim-tree\frequire\0" },
    loaded = true,
    path = "/Users/yasuhiro/.local/share/nvim/site/pack/packer/start/nvim-tree.lua",
    url = "https://github.com/kyazdani42/nvim-tree.lua"
  },
  ["nvim-web-devicons"] = {
    loaded = true,
    path = "/Users/yasuhiro/.local/share/nvim/site/pack/packer/start/nvim-web-devicons",
    url = "https://github.com/kyazdani42/nvim-web-devicons"
  },
  ["packer.nvim"] = {
    loaded = true,
    path = "/Users/yasuhiro/.local/share/nvim/site/pack/packer/start/packer.nvim",
    url = "https://github.com/wbthomason/packer.nvim"
  },
  ["targets.vim"] = {
    loaded = true,
    path = "/Users/yasuhiro/.local/share/nvim/site/pack/packer/start/targets.vim",
    url = "https://github.com/wellle/targets.vim"
  },
  ["vim-easymotion"] = {
    loaded = true,
    path = "/Users/yasuhiro/.local/share/nvim/site/pack/packer/start/vim-easymotion",
    url = "https://github.com/easymotion/vim-easymotion"
  },
  ["vim-surround"] = {
    loaded = true,
    path = "/Users/yasuhiro/.local/share/nvim/site/pack/packer/start/vim-surround",
    url = "https://github.com/tpope/vim-surround"
  },
  ["vscode.nvim"] = {
    loaded = true,
    path = "/Users/yasuhiro/.local/share/nvim/site/pack/packer/start/vscode.nvim",
    url = "https://github.com/Mofiqul/vscode.nvim"
  }
}

time([[Defining packer_plugins]], false)
-- Config for: nvim-tree.lua
time([[Config for nvim-tree.lua]], true)
try_loadstring("\27LJ\2\n�\f\0\0\b\0007\0W6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0004\3\0\0=\3\4\0025\3\5\0=\3\6\0025\3\a\0005\4\b\0=\4\t\3=\3\n\0025\3\v\0004\4\0\0=\4\f\3=\3\r\0025\3\14\0004\4\0\0=\4\15\3=\3\16\0025\3\17\0004\4\0\0=\4\18\3=\3\19\0025\3\20\0=\3\21\0025\3\22\0005\4\23\0004\5\25\0005\6\25\0005\a\24\0=\a\26\6>\6\1\0055\6\27\0>\6\2\0055\6\28\0>\6\3\0055\6\29\0>\6\4\0055\6\30\0>\6\5\0055\6\31\0>\6\6\0055\6 \0>\6\a\0055\6!\0>\6\b\0055\6\"\0>\6\t\0055\6#\0>\6\n\0055\6$\0>\6\v\0055\6%\0>\6\f\0055\6&\0>\6\r\0055\6'\0>\6\14\0055\6(\0>\6\15\0055\6)\0>\6\16\0055\6*\0>\6\17\0055\6+\0>\6\18\0055\6,\0>\6\19\0055\6-\0>\6\20\0055\6.\0>\6\21\0055\6/\0>\6\22\0055\0060\0>\6\23\0055\0061\0>\6\24\5=\0052\4=\0043\3=\0034\0025\0035\0=\0036\2B\0\2\1K\0\1\0\ntrash\1\0\1\20require_confirm\2\tview\rmappings\tlist\1\0\2\vaction\16toggle_help\bkey\6?\1\0\2\vaction\nclose\bkey\6q\1\0\2\vaction\vdir_up\bkey\6u\1\0\2\vaction\23copy_absolute_path\bkey\agy\1\0\2\vaction\14copy_path\bkey\6Y\1\0\2\vaction\14copy_name\bkey\6y\1\0\2\vaction\npaste\bkey\amp\1\0\2\vaction\bcut\bkey\amx\1\0\2\vaction\vrename\bkey\amm\1\0\2\vaction\vremove\bkey\amd\1\0\2\vaction\vcreate\bkey\ama\1\0\2\vaction\frefresh\bkey\6R\1\0\2\vaction\20toggle_dotfiles\bkey\6.\1\0\2\vaction\19toggle_ignored\bkey\6I\1\0\2\vaction\17last_sibling\bkey\6J\1\0\2\vaction\18first_sibling\bkey\6K\1\0\2\vaction\15close_node\bkey\6h\1\0\2\vaction\16parent_node\bkey\6P\1\0\2\vaction\17next_sibling\bkey\6>\1\0\2\vaction\17prev_sibling\bkey\6<\1\0\2\vaction\vtabnew\bkey\n<C-t>\1\0\2\vaction\nsplit\bkey\n<C-x>\1\0\2\vaction\vvsplit\bkey\n<C-v>\bkey\1\0\1\vaction\tedit\1\3\0\0\t<CR>\6l\1\0\1\16custom_only\2\1\0\b\15signcolumn\byes\nwidth\3\30\16auto_resize\1\19relativenumber\1\tside\tleft\21hide_root_folder\1\vheight\3\30\vnumber\1\bgit\1\0\3\vignore\2\ftimeout\3�\3\venable\2\ffilters\vcustom\1\0\1\rdotfiles\1\16system_open\targs\1\0\0\24update_focused_file\16ignore_list\1\0\2\15update_cwd\1\venable\1\16diagnostics\nicons\1\0\4\fwarning\b\tinfo\b\nerror\b\thint\b\1\0\1\venable\1\22update_to_buf_dir\1\0\2\14auto_open\2\venable\2\23ignore_ft_on_setup\1\0\a\15update_cwd\1\18hijack_cursor\1\16open_on_tab\1\15auto_close\1\18open_on_setup\1\17hijack_netrw\2\18disable_netrw\2\nsetup\14nvim-tree\frequire\0", "config", "nvim-tree.lua")
time([[Config for nvim-tree.lua]], false)
-- Config for: lualine.nvim
time([[Config for lualine.nvim]], true)
try_loadstring("\27LJ\2\n�\4\0\0\5\0\31\0/6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\t\0005\3\3\0005\4\4\0=\4\5\0035\4\6\0=\4\a\0034\4\0\0=\4\b\3=\3\n\0025\3\f\0005\4\v\0=\4\r\0035\4\14\0=\4\15\0035\4\16\0=\4\17\0035\4\18\0=\4\19\0035\4\20\0=\4\21\0035\4\22\0=\4\23\3=\3\24\0025\3\25\0004\4\0\0=\4\r\0034\4\0\0=\4\15\0035\4\26\0=\4\17\0035\4\27\0=\4\19\0034\4\0\0=\4\21\0034\4\0\0=\4\23\3=\3\28\0024\3\0\0=\3\29\0024\3\0\0=\3\30\2B\0\2\1K\0\1\0\15extensions\ftabline\22inactive_sections\1\2\0\0\rlocation\1\2\0\0\rfilename\1\0\0\rsections\14lualine_z\1\2\0\0\rlocation\14lualine_y\1\2\0\0\rprogress\14lualine_x\1\4\0\0\rencoding\15fileformat\rfiletype\14lualine_c\1\2\0\0\rfilename\14lualine_b\1\4\0\0\vbranch\tdiff\16diagnostics\14lualine_a\1\0\0\1\2\0\0\tmode\foptions\1\0\0\23disabled_filetypes\23section_separators\1\0\2\nright\b\tleft\b\25component_separators\1\0\2\nright\b\tleft\b\1\0\3\ntheme\tauto\18icons_enabled\2\25always_divide_middle\2\nsetup\flualine\frequire\0", "config", "lualine.nvim")
time([[Config for lualine.nvim]], false)
if should_profile then save_profiles() end

end)

if not no_errors then
  vim.api.nvim_command('echohl ErrorMsg | echom "Error in packer_compiled: '..error_msg..'" | echom "Please check your config for correctness" | echohl None')
end
