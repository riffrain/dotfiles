se encoding=utf-8
scriptencoding utf-8

let g:mapleader = "\<Space>"

if &compatible
  se nocompatible
en

aug MyAutoCmd
  au!
aug END

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

call plug#begin('~/.vim/plugged')

Plug 'editorconfig/editorconfig-vim'
Plug 'cohama/lexima.vim'
Plug 'tpope/vim-surround'
Plug 'wellle/targets.vim'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'vim-syntastic/syntastic'
Plug 'rking/ag.vim'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'itchyny/lightline.vim'
Plug 'easymotion/vim-easymotion'

Plug 't9md/vim-choosewin'
Plug 'preservim/nerdtree'

Plug 'vim-denops/denops.vim'

" LSP {{{
Plug 'Shougo/ddc.vim'
Plug 'Shougo/pum.vim'
Plug 'Shougo/ddc-around'
Plug 'Shougo/ddc-matcher_head'
Plug 'Shougo/ddc-sorter_rank'
Plug 'shun/ddc-vim-lsp'
Plug 'prabirshrestha/vim-lsp'
Plug 'mattn/vim-lsp-settings'
Plug 'matsui54/ddc-buffer'
Plug 'Shougo/ddc-cmdline'
" }}}

" finder {{{
" Plug 'Shougo/vimproc.vim', { 'do': 'make' }
" Plug 'Shougo/unite.vim'
" Plug 'Shougo/ddu.vim'
" Plug 'Shougo/ddu-ui-ff'
" Plug 'Shougo/ddu-source-file_rec'
" Plug 'Shougo/ddu-filter-matcher_substring'
" Plug 'Shougo/ddu-kind-file'
" Plug 'shun/ddu-source-buffer'
" }}}

" colorscheme {{{
" Plug 'Erichain/vim-monokai-pro'
" Plug 'tomasiser/vim-code-dark'
Plug 'ayu-theme/ayu-vim'
" }}}

call plug#end()

autocmd VimEnter *
  \  if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \|   PlugInstall --sync | q
  \| endif

" Load configrations
let s:plugs = get(s:, 'plugs', get(g:, 'plugs', {}))
function! FindPlugin(name) abort
  return has_key(s:plugs, a:name) ? isdirectory(s:plugs[a:name].dir) : 0
endfunction
command! -nargs=1 UsePlugin if !FindPlugin(<args>) | finish | endif

runtime! configs/*.vim
