inoremap jj <Esc>
nnoremap <silent><Esc><Esc> :<C-u>se nohlsearch!<CR>
noremap j gj
noremap k gk
noremap gj j
noremap gk k
noremap <S-j> <Nop>
noremap <S-k> <Nop>
noremap <C-j> 10j
noremap <C-k> 10k
noremap <Leader>n :<C-u>:setl number!<CR>
nnoremap <Leader>s :<C-u>sp<CR>
nnoremap <Leader>v :<C-u>vs<CR>
cnoremap <c-x> <c-r>=expand('%:p')<cr>
if has('terminal')
  tnoremap <Esc><Esc> <C-\><C-n>

  " popup terminal
  function! s:popupterminal()
    call popup_create(
          \ term_start(
          \   [&shell],
          \   #{ hidden: 1, term_finish: 'close'}),
          \   #{ border: [], minwidth: winwidth(0)/2, minheight: &lines/2 }
          \)
  endfunction
  com! -range=% PopupTerminal call s:popupterminal()
endif
