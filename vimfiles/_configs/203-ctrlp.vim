UsePlugin 'ctrlp.vim'

if executable('ag')
  let g:ctrlp_use_caching=0
  let g:ctrlp_user_command='ag %s -i -s --nocolor --nogroup -g ""'
elseif executable('rg')
  set grepformat=%f:%l:%c:%m,%f:%l:%m
  let g:ctrlp_user_command= 'rg %s --files --hidden --glob ""'
  let g:ctrlp_user_command_async = 'rg %s --files --hidden --glob ""'
else
  let g:ctrlp_user_command= ['.git', 'cd %s && git ls-files -co --exclude-standard']
  let g:ctrlp_user_command_async = ['.git', 'cd %s && git ls-files -co --exclude-standard']
endif
let g:ctrlp_show_hidden = 1

if FindPlugin('ctrlp-matchfuzzy')
  let g:ctrlp_match_func = {'match': 'ctrlp_matchfuzzy#matcher'}
endif

let g:ctrlp_compare_lim = 100
let g:ctrlp_lazy_update = 0

nn <Leader>f :CtrlP<CR>
nn <Leader>l :CtrlPLine<CR>
nn <Leader>b :CtrlPBuffer<CR>
nn <Leader>m :CtrlPMixed<CR>
