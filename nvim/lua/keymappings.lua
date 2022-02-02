vim.cmd([[
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

nn <Leader>t <Cmd>terminal<CR>
tno <silent><Esc><Esc> <C-\><C-n>
au TermOpen * startinsert
au WinEnter * if &buftype ==# 'terminal' | startinsert | endif
]])
