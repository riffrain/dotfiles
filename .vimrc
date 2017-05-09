set encoding=utf-8
scriptencoding utf-8

if &compatible
  set nocompatible               " Be iMproved
endif

augroup MyAutoCmd
  autocmd!
augroup END

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
"set showcmd
set ruler
set wildmenu
set showmatch
set matchtime=1
"highlight LineNr ctermfg=darkgray
set list
if has('nvim')
	set listchars=tab:——,trail:·,extends:>,precedes:<,space:·
else
	set listchars=tab:——,trail:·,extends:>,precedes:<
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
set tabstop=4
set shiftwidth=4
set softtabstop=0
set showtabline=2
set t_Co=256
set mouse=

" ハイライトを消す
nnoremap <Esc><Esc> :nohlsearch<CR><Esc>

inoremap jj <Esc>

nnoremap <Leader>e :VimFilerExplorer<CR>
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
  tnoremap ˙ <C-\><C-n><C-w>h
  tnoremap ∆ <C-\><C-n><C-w>j
  tnoremap ˚ <C-\><C-n><C-w>k
  tnoremap ¬ <C-\><C-n><C-w>l
endif

nnoremap <M-h> <C-w>h
nnoremap <M-j> <C-w>j
nnoremap <M-k> <C-w>k
nnoremap <M-l> <C-w>l
nnoremap ˙ <C-w>h
nnoremap ∆ <C-w>j
nnoremap ˚ <C-w>k
nnoremap ¬ <C-w>l

" grep検索
nnoremap <silent> <Leader>g  :<C-u>Unite grep:. -buffer-name=search-buffer<CR>

" カーソル位置の単語をgrep検索
nnoremap <silent> <Leader>cg :<C-u>Unite grep:. -buffer-name=search-buffer<CR><C-R><C-W>

" grep検索結果の再呼出
nnoremap <silent> <Leader>r  :<C-u>UniteResume search-buffer<CR>

" ---------------
" 移動系
" ---------------
nnoremap <C-j> jjjjj
nnoremap <C-k> kkkkk

" [Ctrl]+zでアンドゥ
inoremap <C-z> <Esc>ui
" [Ctrl]+yでリドゥ
inoremap <C-y> <Esc><C-r><Insert>

"let &t_SI = "\<Esc>]50;CursorShape=1\x7"
"let &t_EI = "\<Esc>]50;CursorShape=0\x7"

" ファンクションキーの割り当て
" F1:前のタブ
nnoremap <F1> gT
inoremap <F1> <Esc>gTi
" F2:次のタブ
nnoremap <F2> gt
inoremap <F2> <Esc>gt<Insert>
" F3:下候補
nnoremap <F3> n
inoremap <F3> <Esc>n<Insert>
" F4:上候補
nnoremap <F4> N
inoremap <F4> <Esc>N<Insert>
" F5:マークの下検索
nnoremap <F5> ]'zz
inoremap <F5> <Esc>]'zz<Insert>
" F6:マークの上検索
nnoremap <F6> ['zz
inoremap <F6> <Esc>['zz<Insert>
" F7:マーク一覧
nnoremap <F7> :marks<CR>
inoremap <F7> <Esc>:marks<CR>
" F8:マーク一括削除
nnoremap <F8> :delmarks!<CR>
inoremap <F8> <Esc>:delmarks!<CR><Insert>
" F9:マーク位置保存
nnoremap <F9> :<C-u>call <SID>AutoMarkrement()<CR>
inoremap <F9> <Esc>:<C-u>call <SID>AutoMarkrement()<CR><Insert>
" F10:行番号表示／非表示
nnoremap <F10> :<C-u>setlocal number!<CR>
inoremap <F10> <Esc>:<C-u>setlocal number!<CR><Insert>
" F11:カーソルラインの表示／非表示
nnoremap <F11> :<C-u>setlocal cursorline!<CR>
inoremap <F11> <Esc>:<C-u>setlocal cursorline!<CR><Insert>
" F12:タブ、空白、改行などの可視化ON／OFF
nnoremap <F12> :<C-u>setlocal list!<CR>
inoremap <F12> <Esc>:<C-u>setlocal list!<CR><Insert>

" 「 r」：.vimrcのリロード
noremap <Leader>r :source ~/.vimrc<CR>:noh<CR>
" 「 q」：ファイルを閉じる
nnoremap <Leader>q :<C-u>q<CR>
" 「 Q」：ファイルを強制的に閉じる
nnoremap <Leader>Q :<C-u>q!<CR>
" 「 p」：ペースト
nnoremap <Leader>p :<C-u>set invpaste<CR>
" 「 m」：マウスモードOFF
noremap <Leader>m :<C-u>set mouse=<CR>:set mouse=<CR>
" 「 M」：マウスモードON
noremap <Leader>M :<C-u>set mouse=a<CR>:set mouse=a<CR>
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

" 無限undo Vimを終了しても復元する
if has('persistent_undo')
    set undodir=./.vimundo,~/.vimundo
    set undofile
endif

