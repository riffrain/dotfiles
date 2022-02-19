"
"CtrlP
"
UsePlugin 'ctrlp.vim'
UsePlugin 'ctrlp-matchfuzzy'

if executable('ag')
  let g:ctrlp_use_caching=0
  let g:ctrlp_user_command='ag %s -i -s --nocolor --nogroup -g ""'
en
if executable('rg')
  set grepformat=%f:%l:%c:%m,%f:%l:%m
  let g:ctrlp_user_command= 'rg %s --files --hidden --glob ""'
  let g:ctrlp_user_command_async = 'rg %s --files --hidden --glob ""'
en
let g:ctrlp_show_hidden = 1
let g:ctrlp_match_func = {'match': 'ctrlp_matchfuzzy#matcher'}

nn <Leader>f :CtrlP<CR>
nn <Leader>l :CtrlPLine<CR>
nn <Leader>b :CtrlPBuffer<CR>
