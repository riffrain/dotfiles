set encoding=utf-8
scriptencoding utf-8

let g:mapleader = "\<Space>"

if &compatible
  set nocompatible
endif

augroup MyAutoCmd
  autocmd!
augroup END

" dein.vim {{{
let s:cache_home = '~/.cache'
let s:dein_dir = expand(s:cache_home . '/dein')
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'
if !isdirectory(s:dein_repo_dir)
  call system('git clone https://github.com/Shougo/dein.vim ' . shellescape(s:dein_repo_dir))
endif
if v:version < 800
  call system('cd ' . shellescape(s:dein_repo_dir) . ' && git checkout 1.5')
else
  call system('cd ' . shellescape(s:dein_repo_dir) . ' && git checkout master')
endif

" Required:
let &runtimepath = s:dein_repo_dir .",". &runtimepath
" Load TOML
let s:dein_config_dir = expand(s:cache_home . '/dein_config')
let s:toml_file = s:dein_config_dir.'/dein.toml'
let s:toml_file_vim = s:dein_config_dir.'/vim.toml'
let s:toml_file_vim8 = s:dein_config_dir.'/vim8.toml'
let s:toml_file_neovim = s:dein_config_dir.'/neovim.toml'

" Required:
if dein#load_state(s:dein_dir)
  call dein#begin(s:dein_dir)
  if v:version < 800
    call dein#load_toml(s:toml_file, {'lazy': 0})
    call dein#load_toml(s:toml_file_vim, {'lazy': 0})
  elseif has('nvim')
    call dein#load_toml(s:toml_file_neovim, {'lazy': 0})
  else
    call dein#load_toml(s:toml_file_vim8, {'lazy': 0})
  endif

  " Required:
  call dein#end()
  call dein#save_state()
endif

" Required:
filetype plugin indent on
syntax enable

if dein#check_install()
  call dein#install()
endif
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
" if has('nvim')
"   set listchars=tab:¦\ ,trail:･,extends:>,precedes:<,space:･
" else
"  set listchars=tab:¦\ ,trail:･,extends:>,precedes:<
" endif
set listchars=tab:¦\ ,trail:･,extends:>,precedes:<
set backspace=indent,eol,start
set title
set whichwrap=b,s,[,],<,>
"set smartindent
"set clipboard=unnamed,autoselect
set nocursorline
autocmd InsertLeave * set cursorline!
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
"set noexpandtab
set softtabstop=0
set showtabline=2
set t_Co=256
set mouse=
set incsearch
set hlsearch
if has('nvim')
  let &t_SI .= "\<Esc>[5 q"
  let &t_SR .= "\<Esc>[4 q"
  let &t_EI .= "\<Esc>[3 q"
else
  let &t_SI = "\<Esc>]50;CursorShape=1\x7"
  let &t_EI = "\<Esc>]50;CursorShape=0\x7"
endif
if has("termguicolors")
  set termguicolors
endif
set noshowmode
"set ambiwidth=double
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
      call system('mkdir -p ' . shellescape(s:undo_dir))
    endif
    set undodir=~/.cache/vimundo
    set undofile
endif
" }}}

" Neovim {{{
if has('nvim')
  tnoremap <silent> <ESC> <C-\><C-n>
endif
" }}}

function! MarkMargin (on)
    if exists('b:MarkMargin')
        try
            call matchdelete(b:MarkMargin)
        catch /./
        endtry
        unlet b:MarkMargin
    endif
    if a:on
        let b:MarkMargin = matchadd('ColorColumn', '\%81v\s*\zs\S', 100)
    endif
endfunction

augroup MarkMargin
    autocmd!
    autocmd  BufEnter  *       :call MarkMargin(1)
    autocmd  BufEnter  *.vp*   :call MarkMargin(0)
augroup END
