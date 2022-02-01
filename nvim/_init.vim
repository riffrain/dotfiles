lua require('settings')
lua require('keymappings')

let s:cache_home = '~/.cache'
let s:dein_dir = expand(s:cache_home . '/dein')
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'
if !isdirectory(s:dein_repo_dir)
  cal system('git clone https://github.com/Shougo/dein.vim ' . shellescape(s:dein_repo_dir))
en
cal system('cd ' . shellescape(s:dein_repo_dir) . ' && git checkout master')
let &runtimepath = s:dein_repo_dir .",". &runtimepath
let s:dein_config_dir = expand(s:cache_home . '/dein_config')
let s:toml_file = s:dein_config_dir.'/neovim.toml'
if dein#load_state(s:dein_dir)
  cal dein#begin(s:dein_dir)
  cal dein#load_toml(s:toml_file, {'lazy': 0})
  cal dein#end()
  cal dein#save_state()
en
if dein#check_install()
  cal dein#install()
en
au VimEnter * cal dein#call_hook('post_source')

lua <<< EOF
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
EOF
