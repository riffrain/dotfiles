se encoding=utf-8

let g:mapleader = "\<Space>"

if &compatible
  se nocompatible
en

filetype plugin indent on
syntax on

aug MyAutoGroup
  au!
aug END

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


" Unlimited undo {{{
if has('persistent_undo')
  let s:cache_home = '~/.cache'
  let s:undo_dir = expand(s:cache_home . '/nvimundo')
  if !isdirectory(s:undo_dir)
    cal system('mkdir -p ' . shellescape(s:undo_dir))
  en
  se undodir=~/.cache/nvimundo
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
" aug MarkMargin
"   au!
"   au BufEnter * :cal MarkMargin(1)
" aug END

" Keymapping {{{
ino jj <Esc>
nn <C-l> :<C-u>se nohlsearch!<CR>
no j gj
no k gk
no gj j
no gk k
no <S-j> <Nop>
no <S-k> <Nop>
no <C-j> 10j
no <C-k> 10k
nn <Leader>s :<C-u>sp<CR>
nn <Leader>v :<C-u>vs<CR>
nn <Leader>T :<C-u>tabnew<cr>
no <Leader>n :<C-u>:setl number!<CR>
nn x "_x
nn s "_s
" }}}

" terminal {{{
tno <silent><Esc><Esc> <C-\><C-n>
au MyAutoGroup TermOpen * startinsert
au MyAutoGroup WinEnter * if &buftype ==# 'terminal' | startinsert | endif
" }}}
" au MyAutoGroup QuickfixCmdPost make,grep,grepadd,vimgrep copen

" Netrw {{{
fu! NetrwMapping()
  nmap <buffer> . gh
  nmap <buffer> <C-t> <Nop>
endf

au MyAutoGroup filetype netrw call NetrwMapping()

" inspired by https://github.com/skywind3000/asyncrun.vim/wiki/Get-netrw-using-asyncrun-to-save-remote-files
" required: skywind3000/asyncrun.vim
fu! s:AsyncSaveRemoteFile(...) abort
  let l:tmpfile = tempname()
  sil exe 'w! '.fnameescape(v:cmdarg).' '.fnameescape(tmpfile)

  let curbufname = expand('%')
  let scpurm = '^scp://\([^/#:]\+\)\%([#:]\(\d\+\)\)\=/\(.*\)$'
  let machine = substitute(curbufname,scpurm,'\1','')
  let port = substitute(curbufname,scpurm,'\2','')
  let fname = substitute(curbufname,scpurm,'\3','')
  if port != ''
    let scpcmd = 'scp -P '.shellescape(port)
  else
    let scpcmd = 'scp'
  endif
  let escaped_tmpfile = shellescape(tmpfile, 1)
  let escaped_fname = shellescape(machine.":".fname, 1)
  let bufnr = expand('<abuf>')+ 0
  call asyncrun#run(
    \ '',
    \ { 'post': 'call delete('.escaped_tmpfile.')|call setbufvar('.bufnr.',"&modified",0)|echo "Saved. '.curbufname.'"' },
    \ scpcmd.' '.escaped_tmpfile.' '.escaped_fname)
endfu
com! -range=% -nargs=* AsyncSaveRemoteFile call s:AsyncSaveRemoteFile(<f-args>)

fu! SetupAsyncSaveRemoteFile()
  " disable Netrw's BufWriteCmd
  au! Network BufWriteCmd scp://*
  aug SetAsyncSaveSCP
    au!
    au BufWriteCmd scp://* exe "sil doau BufWritePre ".fnameescape(expand("<amatch>"))|exe "AsyncSaveRemoteFile ".fnameescape(expand("<amatch>"))|exe "sil doau BufWritePost ".fnameescape(expand("<amatch>"))
  aug END
endfu

aug AsyncSaveRemoteFile
  au!
  au VimEnter * call SetupAsyncSaveRemoteFile()
aug END

" required vim-choosewin
fu! MyNetrwBrowse(isLocal)
  let l:wincount = winnr('$')
  let l:fname = netrw#Call('NetrwGetWord')
  let l:ischoose = 0
  if !(l:fname =~ '/$')
    if l:wincount > 2
      let l:winid = win_getid()
      call choosewin#start(range(2, l:wincount))
      let g:netrw_chgwin = winnr()
      call win_gotoid(l:winid)
    en
  en
  let l:path = netrw#Call('NetrwBrowseChgDir', a:isLocal, l:fname)
  if a:isLocal
    call netrw#LocalBrowseCheck(l:path)
  else
    call netrw#Call('NetrwBrowse', 0, l:path)
  en
  if g:netrw_chgwin != -1
    let g:netrw_chgwin = -1
  en
endf

let g:Netrw_UserMaps = []
call add(g:Netrw_UserMaps, ['<CR>', 'MyNetrwBrowse'])
call add(g:Netrw_UserMaps, ['l', 'MyNetrwBrowse'])
call add(g:Netrw_UserMaps, ['o', 'MyNetrwBrowse'])

let g:netrw_altv=1
let g:netrw_keepdir=0
let g:netrw_banner=0
let g:netrw_winsize=20
let g:netrw_liststyle=3
let g:netrw_browse_split=4
" }}}

" fzf {{{
" nn <Leader>f <Cmd>Files<CR>
nn <Leader>l <Cmd>Lines<CR>
nn <Leader>b <Cmd>Buffers<CR>
nn <Leader>g :Rg<Space>
" }}}

" CtrlP {{{
nn <Leader>f <Cmd>CtrlP<CR>
" nn <Leader>l <Cmd>CtrlPLine<CR>
" nn <Leader>b <Cmd>CtrlPBuffer<CR>

let g:ctrlp_show_hidden = 1
set grepformat=%f:%l:%c:%m,%f:%l:%m
let g:ctrlp_use_caching=1

let g:switch_ctrlp_user_command = 0
function! GetGitToplevel() abort
  if g:switch_ctrlp_user_command == 0
    return v:null
  endif
  let l:directory = len(argv()) > 0 ? fnamemodify(argv()[0], ':p:h') : getcwd()
  let l:toplevel = system('git -C '.shellescape(l:directory).' rev-parse --show-toplevel')

  return l:toplevel =~ 'fatal' ? v:null : l:toplevel[:-2]
endfunction
function! SwitchCtrlPUserCommand() abort
  let l:toplevel = GetGitToplevel()
  if l:toplevel is v:null
    echo '[ctrlp] use ripgrep'
    set grepformat=%f:%l:%c:%m,%f:%l:%m
    let g:ctrlp_user_command= 'rg %s --files --glob ""'
    let g:ctrlp_user_command_async = 'rg %s --files --glob ""'
  else
    if g:switch_ctrlp_user_command == 1
      echo '[ctrlp] use git ls-files'
      let g:ctrlp_user_command='git -C %s ls-files -co --exclude-standard'
      let g:ctrlp_user_command_async='git -C %s ls-files -co --exclude-standard'
    elseif g:switch_ctrlp_user_command == 2
      echo '[ctrlp] use git ls-tree'
      let g:ctrlp_user_command='git -C '.shellescape(l:toplevel).' ls-tree -r --name-only --full-name HEAD'
      let g:ctrlp_user_command_async='git -C '.shellescape(l:toplevel).' ls-tree -r --name-only --full-name HEAD'
    endif
  endif
endfunction

call SwitchCtrlPUserCommand()
" }}}

lua require('plugins')

