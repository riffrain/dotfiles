set encoding=utf-8
scriptencoding utf-8

"dein Scripts-----------------------------
if &compatible
  set nocompatible               " Be iMproved
endif

" dein.vimがインストールされていないときはインストール
let s:cache_home = '~/.cache'
let s:dein_dir = expand(s:cache_home . '/dein')
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

let g:mapleader = "\<Space>"

"Settings
set number
set laststatus=2
set showcmd
set ruler
set wildmenu
set showmatch
set matchtime=1
highlight LineNr ctermfg=darkgray
set list
set listchars=tab:——,trail:·,extends:>,precedes:<,space:·
set backspace=indent,eol,start
set title
set whichwrap=b,s,[,],<,>
"set smartindent
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

nnoremap <Left> h
nnoremap <Right> l
nnoremap <Up> k
nnoremap <Down> j
vnoremap <Left> h
vnoremap <Right> l
vnoremap <Up> k
vnoremap <Down> j
inoremap <S-Left> <Esc>vh
inoremap <S-Right> <Esc>vl
inoremap <S-Up> <Esc>vk
inoremap <S-Down> <Esc>vj



if has('nvim')
  "Terminal Mode
  tnoremap <silent> <ESC> <C-\><C-n>
  tnoremap <M-h> <C-\><C-n><C-w>h
  tnoremap <M-j> <C-\><C-n><C-w>j
  tnoremap <M-k> <C-\><C-n><C-w>k
  tnoremap <M-l> <C-\><C-n><C-w>l
  tnoremap ˙ <C-\><C-n><C-w>h      " Mac用
  tnoremap ∆ <C-\><C-n><C-w>j      " Mac用
  tnoremap ˚ <C-\><C-n><C-w>k      " Mac用
  tnoremap ¬ <C-\><C-n><C-w>l      " Mac用
endif

nnoremap <M-h> <C-w>h
nnoremap <M-j> <C-w>j
nnoremap <M-k> <C-w>k
nnoremap <M-l> <C-w>l
nnoremap ˙ <C-w>h      " Mac用
nnoremap ∆ <C-w>j      " Mac用
nnoremap ˚ <C-w>k      " Mac用
nnoremap ¬ <C-w>l      " Mac用

" カッコ保管
inoremap { {}<Left>
inoremap {<Enter> {}<Left><CR><ESC><S-o>
inoremap ( ()<ESC>i
inoremap (<Enter> ()<Left><CR><ESC><S-o>

" Tab設定
set tabstop=4
set shiftwidth=4
set softtabstop=0

" agが使える場合は、Unite.vimのgrepでagを使う
if executable('ag')
  let g:unite_source_grep_command = 'ag'
  let g:unite_source_grep_default_opts = '--nogroup --nocolor --column'
  let g:unite_source_grep_recursive_opt = ''
endif

" grep検索
nnoremap <silent> <Leader>g  :<C-u>Unite grep:. -buffer-name=search-buffer<CR>

" カーソル位置の単語をgrep検索
nnoremap <silent> <Leader>cg :<C-u>Unite grep:. -buffer-name=search-buffer<CR><C-R><C-W>

" grep検索結果の再呼出
nnoremap <silent> <Leader>r  :<C-u>UniteResume search-buffer<CR>


