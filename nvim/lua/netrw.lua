-- Netrw
vim.cmd([[
nn <Leader>e :Lexplore<CR>

augroup netrw_mapping
  autocmd!
  autocmd filetype netrw call NetrwMapping()
augroup END

fu! NetrwMapping()
  nmap <buffer> . gh
  nmap <buffer> <C-t> <Nop>
endf

let g:Netrw_UserMaps = []
call add(g:Netrw_UserMaps, ['<CR>', 'MyNetrwBrowse'])
call add(g:Netrw_UserMaps, ['l', 'MyNetrwBrowse'])
call add(g:Netrw_UserMaps, ['o', 'MyNetrwBrowse'])

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
  el
    call netrw#Call('NetrwBrowse', 0, l:path)
  en
  if g:netrw_chgwin != -1
    let g:netrw_chgwin = -1
  en
endf

let g:netrw_altv=1
let g:netrw_keepdir=0
let g:netrw_banner=0
let g:netrw_winsize=20
let g:netrw_liststyle=3
let g:netrw_browse_split=4
]])
