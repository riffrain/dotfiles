UsePlugin 'nerdtree'

let g:NERDTreeMouseMode = 0
let g:NERDTreeMapToggleHidden = '.'
let g:NERDTreeMapCustomOpen = 'o'
let g:NERDTreeMapActivateNode = '<CR>'

nnoremap <Leader>e :NERDTreeToggle<CR>

function! OpenCurrentDir(dirNode) abort
  if !a:dirNode.isRoot() && !a:dirNode.isOpen
    call a:dirNode.activate({})
    let l:children = a:dirNode.getVisibleChildren()
    if len(children) > 0
      call l:children[0].putCursorHere(1, 0)
    endif
  endif
endfunction

function! CloseCurrentDir(node) abort
  let l:node = a:node.path.isDirectory ? a:node.getCascadeRoot() : a:node
  if !l:node.isRoot() && !empty(l:node.parent) && !l:node.parent.isRoot() && l:node.parent.isOpen
    call l:node.parent.putCursorHere(1, 0)
    call l:node.parent.activate({})
  endif
endfunction

if FindPlugin('vim-choosewin')
  function! ChooseWinOpen(fileNode) abort
    let l:wincount = winnr('$')
    if l:wincount > 2
      let l:nardwinnr = winnr()
      cal choosewin#start(range(2, l:wincount))
      silent exe l:nardwinnr.'wincmd w'
    endif
    call a:fileNode.activate({ 'reuse': 'all', 'where': 'p', 'keepopen': 1 })
  endfunction
endif

augroup MyNERDTreeConfig
  autocmd!
  autocmd VimEnter * call NERDTreeAddKeyMap({ 'key': 'l', 'callback': 'OpenCurrentDir', 'scope': 'DirNode', 'quickhelpText': 'Open current dir' })
  autocmd VimEnter * call NERDTreeAddKeyMap({ 'key': 'h', 'callback': 'CloseCurrentDir', 'scope': 'Node', 'quickhelpText': 'Close current dir' })
  if exists('*ChooseWinOpen')
    autocmd VimEnter * call NERDTreeAddKeyMap({ 'key': g:NERDTreeMapActivateNode, 'callback': 'ChooseWinOpen', 'scope': 'FileNode', 'override': 1 })
  endif
augroup END
