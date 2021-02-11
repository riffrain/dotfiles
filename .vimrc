set encoding=utf-8
scriptencoding utf-8

let g:mapleader = "\<Space>"

if &compatible
  set nocompatible
en

aug MyAutoCmd
  au!
aug END

" dein.vim {{{
let s:cache_home = '~/.cache'
let s:dein_dir = expand(s:cache_home . '/dein')
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'
if !isdirectory(s:dein_repo_dir)
  cal system('git clone https://github.com/Shougo/dein.vim ' . shellescape(s:dein_repo_dir))
en
if v:version < 800
  cal system('cd ' . shellescape(s:dein_repo_dir) . ' && git checkout 1.5')
else
  cal system('cd ' . shellescape(s:dein_repo_dir) . ' && git checkout master')
en

" Required:
let &runtimepath = s:dein_repo_dir .",". &runtimepath
" Load TOML
let s:dein_config_dir = expand(s:cache_home . '/dein_config')
let s:toml_file = s:dein_config_dir.'/dein.toml'
let s:toml_file_vim8 = s:dein_config_dir.'/vim8.toml'

" Required:
if dein#load_state(s:dein_dir)
  cal dein#begin(s:dein_dir)
  cal dein#load_toml(s:toml_file, {'lazy': 0})
  if v:version >= 800
    cal dein#load_toml(s:toml_file_vim8, {'lazy': 0})
  en

  " Required:
  cal dein#end()
  cal dein#save_state()
en

" Required:
filetype plugin indent on
syntax enable

if dein#check_install()
  cal dein#install()
en
" }}}

" Settings {{{
set number
set laststatus=2
set showcmd
set ruler
set wildmenu
set showmatch
set matchtime=1
set list
set listchars=tab:¦\ ,trail:･,extends:>,precedes:<
set backspace=indent,eol,start
set title
set whichwrap=b,s,[,],<,>
set nocursorline
au InsertLeave * set cursorline!
set fenc=utf-8
set nobackup
set noswapfile
set visualbell
set wildmode=list:longest
set nobackup
set noswapfile
set tabstop=2
set shiftwidth=2
set expandtab
set softtabstop=0
set showtabline=2
set t_Co=256
set mouse=
set incsearch
set hlsearch
let &t_SI = "\<Esc>]50;CursorShape=1\x7"
let &t_EI = "\<Esc>]50;CursorShape=0\x7"
if has("termguicolors")
  set termguicolors
en
set noshowmode
set background=dark
" }}}

" Keymaps {{{
inoremap jj <Esc>
nnoremap <silent><Esc><Esc> :<C-u>set nohlsearch!<CR>
noremap <Left> h
noremap <Right> l
noremap <Up> gk
noremap <Down> gj
noremap j gj
noremap k gk
noremap gj j
noremap gk k
noremap <S-j> <C-d>
noremap <S-k> <C-u>
noremap <C-j> 10j
noremap <C-k> 10k

nnoremap <Leader>p :<C-u>set invpaste<CR>
noremap <Leader>a :<C-u>set mouse=<CR>
noremap <Leader>A :<C-u>set mouse=a<CR>
nnoremap <Leader>s :<C-u>sp<CR>
nnoremap <Leader>v :<C-u>vs<CR>
nnoremap <Leader>S :<C-u>sp <TAB>
nnoremap <Leader>V :<C-u>vs <TAB>
nnoremap <Leader>t :<C-u>tabnew<cr>
nnoremap <Leader>T :<C-u>tabnew <TAB>
noremap <Leader>n :<C-u>:setlocal number!<CR>
noremap <Leader>c :<C-u>:setlocal cursorline!<CR>
noremap <Leader>C :<C-u>:setlocal cursorcolumn!<CR>
noremap <Leader>l :<C-u>:setlocal list!<CR>
"}}}

" Unlimited undo {{{
if has('persistent_undo')
    let s:undo_dir = expand(s:cache_home . '/vimundo')
    if !isdirectory(s:undo_dir)
      cal system('mkdir -p ' . shellescape(s:undo_dir))
    en
    set undodir=~/.cache/vimundo
    set undofile
en
" }}}

fu! MarkMargin (on)
    if exists('b:MarkMargin')
        try
            cal matchdelete(b:MarkMargin)
        catch /./
        endtry
        unlet b:MarkMargin
    en
    if a:on
        let b:MarkMargin = matchadd('ColorColumn', '\%81v\s*\zs\S', 100)
    en
endf

aug MarkMargin
    au!
    au  BufEnter  *       :cal MarkMargin(1)
    au  BufEnter  *.vp*   :cal MarkMargin(0)
aug END
