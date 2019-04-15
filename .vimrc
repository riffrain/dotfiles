set encoding=utf-8
scriptencoding utf-8

if &compatible
  set nocompatible               " Be iMproved
endif

augroup MyAutoCmd
  autocmd!
augroup END

" dein.vim {{{
let s:cache_home = '~/.cache'
let s:dein_dir = expand(s:cache_home . '/dein')
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'
if !isdirectory(s:dein_repo_dir)
  call system('git clone --depth=1 -b 1.5 https://github.com/Shougo/dein.vim ' . shellescape(s:dein_repo_dir))
endif
" Required:
let &runtimepath = s:dein_repo_dir .",". &runtimepath
" Load TOML
let s:toml_file = s:dein_dir.'/dein.toml'
let s:toml_file_lazy = s:dein_dir.'/lazy.toml'
let s:toml_file_neovim = s:dein_dir.'/neovim.toml'

" Required:
if dein#load_state(s:dein_dir)
  call dein#begin(s:dein_dir)
  " Load common toml
  call dein#load_toml(s:toml_file, {'lazy': 0})
  " Load lazy toml
  call dein#load_toml(s:toml_file_lazy, {'lazy': 0})
  " Load neovim toml
  if has('nvim')
    call dein#load_toml(s:toml_file_neovim, {'lazy': 1})
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

" =============
" Settings
" =============
set number
set laststatus=2
"set showcmd
set ruler
set wildmenu
set showmatch
set matchtime=1
set list
if has('nvim')
  set listchars=tab:¦\ ,trail:･,extends:>,precedes:<,space:･
else
  set listchars=tab:¦\ ,trail:･,extends:>,precedes:<
endif
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
let &t_SI = "\<Esc>]50;CursorShape=1\x7"
let &t_EI = "\<Esc>]50;CursorShape=0\x7"
if has("termguicolors")
  set termguicolors
endif
set noshowmode
"set ambiwidth=double

let g:mapleader = "\<Space>"
let g:vue_disable_pre_processors=1

" autocmd BufNewFile,BufRead *.vue set filetype=html "When opening or creating a .vue file set the filetype to HTML for proper rendering

" ===========================
" keymap
" ===========================
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

" vimfiler {{{
nnoremap <Leader>e :VimFilerExplorer<CR>
" }}}

" unite.vim {{{
nnoremap <silent> <Leader>g  :<C-u>Unite grep:. -buffer-name=search-buffer<CR>
nnoremap <silent> <Leader>cg :<C-u>Unite grep:. -buffer-name=search-buffer<CR><C-R><C-W>
nnoremap <silent> <Leader>r  :<C-u>UniteResume search-buffer<CR>
nnoremap <silent> <Leader>b  :<C-u>Unite buffer<CR>

nnoremap <silent> <Leader>m  :<C-u>Unite mark<CR>
" }}}

" " Function key {{{
" " F1:前のタブ
" nnoremap <F1> gT
" inoremap <F1> <Esc>gTi
" " F2:次のタブ
" nnoremap <F2> gt
" inoremap <F2> <Esc>gt<Insert>
" " F3:下候補
" nnoremap <F3> n
" inoremap <F3> <Esc>n<Insert>
" " F4:上候補
" nnoremap <F4> N
" inoremap <F4> <Esc>N<Insert>
" " F5:マークの下検索
" nnoremap <F5> ]'zz
" inoremap <F5> <Esc>]'zz<Insert>
" " F6:マークの上検索
" nnoremap <F6> ['zz
" inoremap <F6> <Esc>['zz<Insert>
" " F7:マーク一覧
" nnoremap <F7> :marks<CR>
" inoremap <F7> <Esc>:marks<CR>
" " F8:マーク一括削除
" nnoremap <F8> :delmarks!<CR>
" inoremap <F8> <Esc>:delmarks!<CR><Insert>
" " F9:マーク位置保存
" nnoremap <F9> :<C-u>call <SID>AutoMarkrement()<CR>
" inoremap <F9> <Esc>:<C-u>call <SID>AutoMarkrement()<CR><Insert>
" " F10:行番号表示／非表示
" nnoremap <F10> :<C-u>setlocal number!<CR>
" inoremap <F10> <Esc>:<C-u>setlocal number!<CR><Insert>
" " F11:カーソルラインの表示／非表示
" nnoremap <F11> :<C-u>setlocal cursorline!<CR>
" inoremap <F11> <Esc>:<C-u>setlocal cursorline!<CR><Insert>
" " F12:タブ、空白、改行などの可視化ON／OFF
" nnoremap <F12> :<C-u>setlocal list!<CR>
" inoremap <F12> <Esc>:<C-u>setlocal list!<CR><Insert>
" " }}}

" Leader {{{
" 「 p」：ペースト
nnoremap <Leader>p :<C-u>set invpaste<CR>
" 「 m」：マウスモードOFF
noremap <Leader>a :<C-u>set mouse=<CR>
" 「 M」：マウスモードON
noremap <Leader>A :<C-u>set mouse=a<CR>
" 「 s」：ウィンドウを縦分割
nnoremap <Leader>s :<C-u>sp<CR>
" 「 v」：ウィンドウを横分割
nnoremap <Leader>v :<C-u>vs<CR>
" 「 S」：ウィンドウを縦分割(ファイルを選択)
nnoremap <Leader>S :<C-u>sp <TAB>
" 「 V」：ウィンドウを横分割（ファイルを選択）
nnoremap <Leader>V :<C-u>vs <TAB>
" 「 t」：新規タブを作成
nnoremap <Leader>t :<C-u>tabnew<cr>
" 「 T」：新規タブを作成（ファイルを選択）
nnoremap <Leader>T :<C-u>tabnew <TAB>
" 「 n」：行番号表示／非表示
noremap <Leader>n :<C-u>:setlocal number!<CR>
" 「 c」：カーソルラインの表示／非表示
noremap <Leader>c :<C-u>:setlocal cursorline!<CR>
" 「 C」：カーソルカラムの表示／非表示
noremap <Leader>C :<C-u>:setlocal cursorcolumn!<CR>
" 「 l」：タブ、空白、改行などの可視化ON／OFF
noremap <Leader>l :<C-u>:setlocal list!<CR>
"" 「 r」：.vimrcのリロード
"noremap <leader>r :source ~/.vimrc<cr>:noh<cr>
"" 「 q」：ファイルを閉じる
"nnoremap <Leader>q :<C-u>q<CR>
"" 「 Q」：ファイルを強制的に閉じる
"nnoremap <Leader>Q :<C-u>q!<CR>
" }}}

"" Ctrl+* {{{
"" [Ctrl]+zでアンドゥ
"inoremap <C-z> <Esc>ui
"" [Ctrl]+yでリドゥ
"inoremap <C-y> <Esc><C-r><Insert>
" }}}

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

" NeoVim {{{
if has('nvim')
  tnoremap <silent> <ESC> <C-\><C-n>
endif
" }}}

" neosnippet {{{
inoremap <expr><S-TAB>  pumvisible() ? "\<C-p>" : "\<S-TAB>"
imap <C-k> <Plug>(neosnippet_expand_or_jump)
smap <C-k> <Plug>(neosnippet_expand_or_jump)
imap <expr><TAB>
 \ pumvisible() ? "\<C-n>" :
 \ neosnippet#expandable_or_jumpable() ?
 \    "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"

smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
" }}}

highlight ColorColumn ctermfg=208 ctermbg=Black
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

" runtime .vim/plugin/dragvisuals.vim
"
" vmap  <expr>  <LEFT>   DVB_Drag('left')
" vmap  <expr>  <RIGHT>  DVB_Drag('right')
" vmap  <expr>  <DOWN>   DVB_Drag('down')
" vmap  <expr>  <UP>     DVB_Drag('up')
" vmap  <expr>  D        DVB_Duplicate()
"
" let g:DVB_TrimWS = 1
