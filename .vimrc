"dein Scripts-----------------------------
if &compatible
  set nocompatible               " Be iMproved
endif

" dein.vimがインストールされていないときはインストール
let s:cache_home = '~/.cache'
let s:dein_dir = s:cache_home . '/dein'
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'
if !isdirectory(s:dein_repo_dir)
  call system('git clone https://github.com/Shougo/dein.vim ' . shellescape(s:dein_repo_dir))
endif

" Required:
let &runtimepath = s:dein_repo_dir .",". &runtimepath

" Load TOML
let s:toml_file = s:dein_dir.'/dein.toml'

" Required:
if dein#load_state(s:dein_dir)
  call dein#begin(s:dein_dir)
  call dein#load_toml(s:toml_file)

  " Required:
  call dein#end()
  call dein#save_state()
endif

" Required:
filetype plugin indent on
syntax enable

" If you want to install not installed plugins on startup.
if dein#check_install()
  call dein#install()
endif

"End dein Scripts-------------------------

let mapleader = "\<Space>"

"Settings
set number
set laststatus=2
set showcmd
set ruler
set wildmenu
set showmatch
highlight LineNr ctermfg=darkgray
set list
set listchars=tab:»-,trail:-,extends:»,precedes:«,nbsp:%
set backspace=indent,eol,start
set title
set whichwrap=b,s,[,],<,>
set smartindent
set cursorline
"set clipboard=unnamed,autoselect
set fenc=utf-8
set nobackup
set noswapfile
set visualbell
set wildmode=list:longest

"Mapping
nmap <Esc><Esc> :nohlsearch<CR><Esc>
inoremap jj <Esc>
nmap <Leader>e :VimFilerExplorer<CR>

"ColorScheme
set background=dark
colorscheme hybrid

set nobackup
set noswapfile
set fenc=utf-8

