UsePlugin 'phpactor'

autocmd vimrc FileType php setlocal omnifunc=phpactor#Complete

augroup PhpactorMappings
  au!
  au FileType php nmap <buffer> <Leader>u :PhpactorImportClass<CR>
  au FileType php nmap <buffer> <Leader>ce :PhpactorClassExpand<CR>
  au FileType php nmap <buffer> <Leader>ua :PhpactorImportMissingClasses<CR>
  au FileType php nmap <buffer> <Leader>mm :PhpactorContextMenu<CR>
  au FileType php nmap <buffer> <Leader>nn :PhpactorNavigate<CR>
  au FileType php,cucumber nmap <buffer> <Leader>gd
      \ :PhpactorGotoDefinition edit<CR>
  au FileType php nmap <buffer> <Leader>K :PhpactorHover<CR>
  au FileType php nmap <buffer> <Leader>tt :PhpactorTransform<CR>
  au FileType php nmap <buffer> <Leader>cc :PhpactorClassNew<CR>
  au FileType php nmap <buffer> <Leader>ci :PhpactorClassInflect<CR>
  au FileType php nmap <buffer> <Leader>fr :PhpactorFindReferences<CR>
  au FileType php nmap <buffer> <Leader>mf :PhpactorMoveFile<CR>
  au FileType php nmap <buffer> <Leader>cf :PhpactorCopyFile<CR>
  au FileType php nmap <buffer> <silent> <Leader>ee
      \ :PhpactorExtractExpression<CR>
  au FileType php vmap <buffer> <silent> <Leader>ee
      \ :<C-u>PhpactorExtractExpression<CR>
  au FileType php vmap <buffer> <silent> <Leader>em
      \ :<C-u>PhpactorExtractMethod<CR>
augroup END
