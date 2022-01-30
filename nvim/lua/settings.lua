vim.cmd([[
se encoding=utf-8

let g:mapleader = "\<Space>"

if &compatible
  se nocompatible
en

aug MyAutoCmd
  au!
aug END

let s:cache_home = '~/.cache'

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
" }}}


" Unlimited undo {{{
if has('persistent_undo')
    let s:undo_dir = expand(s:cache_home . '/nvimundo')
    if !isdirectory(s:undo_dir)
      cal system('mkdir -p ' . shellescape(s:undo_dir))
    en
    se undodir=~/.cache/nvimundo
    se undofile
en
" }}}

fu! MarkMargin (on)
  if exists('b:MarkMargin')
    try
      cal matchdelete(b:MarkMargin)
    cat /./
    endt
    unlet b:MarkMargin
  en
  if a:on
    let b:MarkMargin = matchadd('ColorColumn', '\%81v\s*\zs\S', 100)
  en
endf

aug MarkMargin
  au!
  au BufEnter * :cal MarkMargin(1)
  au BufEnter *.vp* :cal MarkMargin(0)
aug END
]])
