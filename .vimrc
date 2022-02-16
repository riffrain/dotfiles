se encoding=utf-8
scriptencoding utf-8

let g:mapleader = "\<Space>"

if &compatible
  se nocompatible
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
let &runtimepath = s:dein_repo_dir .",". &runtimepath
let s:dein_config_dir = expand(s:cache_home . '/dein_config')
let s:toml_file = s:dein_config_dir.'/dein.toml'
let s:toml_file_vim8 = s:dein_config_dir.'/vim8.toml'
if dein#load_state(s:dein_dir)
  cal dein#begin(s:dein_dir)
  if v:version >= 800
    cal dein#load_toml(s:toml_file_vim8, {'lazy': 0})
  else
    cal dein#load_toml(s:toml_file, {'lazy': 0})
  en
  cal dein#end()
  cal dein#save_state()
en
if dein#check_install()
  cal dein#install()
en
au VimEnter * cal dein#call_hook('post_source')
" }}}

filetype plugin indent on
syntax enable

" Settings {{{
se number
se laststatus=2
se showcmd
se ruler
se wildmenu
se showmatch
se matchtime=1
se list
se listchars=tab:¦\ ,trail:･,extends:>,precedes:<
se backspace=indent,eol,start
se title
se whichwrap=b,s,[,],<,>
se nocursorline
au InsertLeave * se cursorline!
se fenc=utf-8
se nobackup
se noswapfile
se visualbell
se wildmode=list:longest
se nobackup
se noswapfile
se tabstop=2
se shiftwidth=2
se expandtab
se softtabstop=0
se showtabline=2
se t_Co=256
se mouse=
se incsearch
se hlsearch
let &t_SI = "\<Esc>]50;CursorShape=1\x7"
let &t_EI = "\<Esc>]50;CursorShape=0\x7"
if has("termguicolors")
  se termguicolors
en
se noshowmode
se background=dark
se signcolumn=yes
" }}}

" Keymaps {{{
ino jj <Esc>
nn <silent><Esc><Esc> :<C-u>se nohlsearch!<CR>
no j gj
no k gk
no gj j
no gk k
no <S-j> <Nop>
no <S-k> <Nop>
no <C-j> 10j
no <C-k> 10k
nn <Leader>p :<C-u>se invpaste<CR>
nn <Leader>s :<C-u>sp<CR>
nn <Leader>v :<C-u>vs<CR>
nn <Leader>T :<C-u>tabnew<cr>
no <Leader>n :<C-u>:setl number!<CR>
"}}}

" Unlimited undo {{{
if has('persistent_undo')
    let s:undo_dir = expand(s:cache_home . '/vimundo')
    if !isdirectory(s:undo_dir)
      cal system('mkdir -p ' . shellescape(s:undo_dir))
    en
    se undodir=~/.cache/vimundo
    se undofile
en
" }}}

" fu! MarkMargin (on)
"   if exists('b:MarkMargin')
"     try
"       cal matchdelete(b:MarkMargin)
"     cat /./
"     endt
"     unlet b:MarkMargin
"   en
"   if a:on
"     let b:MarkMargin = matchadd('ColorColumn', '\%81v\s*\zs\S', 100)
"   en
" endf
"
" aug MarkMargin
"   au!
"   au BufEnter * :cal MarkMargin(1)
"   au BufEnter *.vp* :cal MarkMargin(0)
" aug END
