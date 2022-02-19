" global keymappings

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
cnoremap <c-x> <c-r>=expand('%:p')<cr>
if has('terminal')
  tnoremap <Esc><Esc> <C-\><C-n>
endif
