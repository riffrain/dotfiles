"dein Scripts-----------------------------
if &compatible
  set nocompatible               " Be iMproved
endif

" Required:
set runtimepath+=~/.cache/dein/repos/github.com/Shougo/dein.vim

" Required:
if dein#load_state('~/.cache/dein')
  call dein#begin('~/.cache/dein')

  " Let dein manage dein
  " Required:
  call dein#add('~/.cache/dein/repos/github.com/Shougo/dein.vim')

  " Add or remove your plugins here:
  call dein#add('Shougo/neosnippet.vim')
  call dein#add('Shougo/neosnippet-snippets')
  " You can specify revision/branch/tag.
  call dein#add('Shougo/vimshell', { 'rev': '3787e5' })

  call dein#add('mattn/emmet-vim')
  call dein#add('bling/vim-airline')
  call dein#add('vim-airline/vim-airline-themes')
  call dein#add('scrooloose/nerdtree')
  call dein#add('w0ng/vim-hybrid')

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

"Plugin Settings
let g:airline_powerline_fonts=1
let g:airline_theme='powerlineish'
let g:airline_left_sep=''
let g:airline_right_sep=''
let g:airline_section_z=''
let g:airline#extensions#tabline#enabled = 1
let g:user_emmet_leader_key='<C-e>'

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
set background=dark
colorscheme hybrid
set clipboard=unnamed,autoselect
set fenc=utf-8
set nobackup
set noswapfile
set visualbell
set wildmode=list:longest

"Mapping
nmap <Esc><Esc> :nohlsearch<CR><Esc>
inoremap jj <Esc>

