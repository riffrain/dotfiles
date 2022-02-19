"
" lightline.vim
"
if empty(globpath(&rtp, 'autoload/lightline.vim'))
  finish
endif

let g:lightline = {
    \ 'colorscheme': 'ayu',
    \ 'component': {
    \   'readonly': '%{&readonly?"\ue0a2":""}',
    \ },
    \ 'active': {
    \   'left': [ [ 'mode', 'paste' ], [ 'fugitive', 'filename' ], ['ctrlpmark'] ],
    \   'right': [ [ 'syntastic', 'lineinfo' ], ['percent'], [ 'fileformat', 'fileencoding', 'filetype' ] ]
    \ },
    \ 'component_function': {
    \   'fugitive': 'LightlineFugitive',
    \   'filename': 'LightlineFilename',
    \   'fileformat': 'LightlineFileformat',
    \   'filetype': 'LightlineFiletype',
    \   'fileencoding': 'LightlineFileencoding',
    \   'mode': 'LightlineMode',
    \   'ctrlpmark': 'CtrlPMark',
    \ },
    \ 'component_expand': {
    \   'syntastic': 'SyntasticStatuslineFlag',
    \ },
    \ 'component_type': {
    \   'syntastic': 'error',
    \ }
    \ }

fu! LightlineModified()
  retu &ft =~ 'help' ? '' : &modified ? '+' : &modifiable ? '' : '-'
endf

fu! LightlineReadonly()
  retu &ft !~? 'help' && &readonly ? 'RO' : ''
endf

fu! LightlineFilename()
  let fname = expand('%:~')
  retu fname == 'ControlP' && has_key(g:lightline, 'ctrlp_item') ? g:lightline.ctrlp_item :
    \ fname == '__Tagbar__' ? g:lightline.fname :
    \ fname =~ '__Gundo\|NERD_tree' ? '' :
    \ &ft == 'vimfiler' ? '' :
    \ &ft == 'unite' ? unite#get_status_string() :
    \ &ft == 'vimshell' ? vimshell#get_status_string() :
    \ ('' != LightlineReadonly() ? LightlineReadonly() . ' ' : '') .
    \ ('' != fname ? fname : '[No Name]') .
    \ ('' != LightlineModified() ? ' ' . LightlineModified() : '')
endf

fu! LightlineFugitive()
  try
    if expand('%:t') !~? 'Tagbar\|Gundo\|NERD' && &ft !~? 'vimfiler'
      let branch = fugitive#head()
      retu branch !=# '' ? branch : ''
    en
  catch
  endtry
  retu ''
endf

fu! LightlineFileformat()
  retu winwidth(0) > 70 ? &fileformat : ''
endf

fu! LightlineFiletype()
  retu winwidth(0) > 70 ? (&filetype !=# '' ? &filetype : 'no ft') : ''
endf

fu! LightlineFileencoding()
  retu winwidth(0) > 70 ? (&fenc !=# '' ? &fenc : &enc) : ''
endf

fu! LightlineMode()
  let fname = expand('%:t')
  retu fname == 'ControlP' ? 'CtrlP' :
    \ fname =~ 'NERD_tree' ? 'NERDTree' :
    \ &ft == 'unite' ? 'Unite' :
    \ winwidth(0) > 60 ? lightline#mode() : ''
endf

fu! CtrlPMark()
  if expand('%:t') =~ 'ControlP' && has_key(g:lightline, 'ctrlp_item')
    cal lightline#link('iR'[g:lightline.ctrlp_regex])
    retu lightline#concatenate([g:lightline.ctrlp_prev, g:lightline.ctrlp_item
        \ , g:lightline.ctrlp_next], 0)
  el
    retu ''
  en
endf

let g:ctrlp_status_func = {
  \ 'main': 'CtrlPStatusFunc_1',
  \ 'prog': 'CtrlPStatusFunc_2',
  \ }

fu! CtrlPStatusFunc_1(focus, byfname, regex, prev, item, next, marked)
  let g:lightline.ctrlp_regex = a:regex
  let g:lightline.ctrlp_prev = a:prev
  let g:lightline.ctrlp_item = a:item
  let g:lightline.ctrlp_next = a:next
  retu lightline#statusline(0)
endf

fu! CtrlPStatusFunc_2(str)
  retu lightline#statusline(0)
endf

let g:tagbar_status_func = 'TagbarStatusFunc'

fu! TagbarStatusFunc(current, sort, fname, ...) abort
  let g:lightline.fname = a:fname
  retu lightline#statusline(0)
endf

aug AutoSyntastic
  au!
  au BufWritePost *.c,*.cpp cal s:syntastic()
aug END

fu! s:syntastic()
  SyntasticCheck
  cal lightline#update()
endf
