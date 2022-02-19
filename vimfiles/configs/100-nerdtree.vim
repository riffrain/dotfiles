"
" NERDTree
"
" if empty(globpath(&rtp, 'autoload/nerd.vim'))
"   finish
" endif

let g:NERDTreeMouseMode = 0
let g:NERDTreeMapToggleHidden = '.'
let g:NERDTreeMapCustomOpen = 'o'
let g:NERDTreeMapActivateNode = '<CR>'

nn <Leader>e :NERDTreeToggle<CR>

aug MyNERDTreeConfig
  au!
  au VimEnter * cal NERDTreeAddKeyMap({ 'key': 'l', 'callback': 'OpenCurrentDir', 'scope': 'DirNode', 'quickhelpText': 'Open current dir' })
  au VimEnter * cal NERDTreeAddKeyMap({ 'key': 'h', 'callback': 'CloseCurrentDir', 'scope': 'Node', 'quickhelpText': 'Close current dir' })
  au VimEnter * cal NERDTreeAddKeyMap({ 'key': g:NERDTreeMapActivateNode, 'callback': 'ChooseWinOpen', 'scope': 'FileNode', 'override': 1 })
aug END

fu! OpenCurrentDir(dirNode) abort
  if !a:dirNode.isRoot() && !a:dirNode.isOpen
    cal a:dirNode.activate({})
    let l:children = a:dirNode.getVisibleChildren()
    cal l:children[0].putCursorHere(1, 0)
  en
endf

fu! CloseCurrentDir(node) abort
  let l:node = a:node.path.isDirectory ? a:node.getCascadeRoot() : a:node
  if !l:node.isRoot() && !empty(l:node.parent) && !l:node.parent.isRoot() && l:node.parent.isOpen
    cal l:node.parent.putCursorHere(1, 0)
    cal l:node.parent.activate({})
  en
endf

fu! ChooseWinOpen(fileNode) abort
  let l:wincount = winnr('$')
  if l:wincount > 2
    let l:nardwinnr = winnr()
    cal choosewin#start(range(2, l:wincount))
    silent exe l:nardwinnr.'wincmd w'
  en
  cal a:fileNode.activate({ 'reuse': 'all', 'where': 'p', 'keepopen': 1 })
endf
