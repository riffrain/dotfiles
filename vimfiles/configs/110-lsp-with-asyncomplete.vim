UsePlugin 'vim-lsp'
UsePlugin 'asyncomplete.vim'
UsePlugin 'asyncomplete-lsp.vim'

function! s:on_lsp_buffer_enabled() abort

  if FindPlugin('asyncomplete-buffer.vim')
    call asyncomplete#register_source(asyncomplete#sources#buffer#get_source_options({
      \ 'name': 'buffer',
      \ 'allowlist': ['*'],
      \ 'completor': function('asyncomplete#sources#buffer#completor'),
      \ 'config': {
      \    'max_buffer_size': 5000000,
      \  },
      \ }))
  endif

  setlocal omnifunc=lsp#complete
  setlocal signcolumn=yes

  " inoremap <expr> <cr> pumvisible() ? "\<c-y>\<cr>" : "\<cr>"
  inoremap <expr> <cr> pumvisible() ? asyncomplete#close_popup() : "\<cr>"

  nmap <buffer> gd <plug>(lsp-peek-definition)
  nmap <buffer> gD <plug>(lsp-definition)
  nmap <buffer> [g <plug>(lsp-previous-diagnostic)
  nmap <buffer> ]g <plug>(lsp-next-diagnostic)
  nmap <buffer> <S-k> <plug>(lsp-hover)
  nnoremap <buffer> <expr><c-d> lsp#scroll(+8)
  nnoremap <buffer> <expr><c-f> lsp#scroll(-8)
endfunction

augroup lsp_install
  au!
  autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
augroup END

let g:lsp_completion_documentation_enabled = 1
let g:lsp_completion_documentation_delay = 50
let g:lsp_diagnostics_enabled = 1
let g:lsp_diagnostics_echo_cursor = 0
let g:lsp_diagnostics_echo_delay = 50
let g:lsp_diagnostics_float_cursor = 1
let g:lsp_diagnostics_float_delay = 1000
let g:lsp_semantic_enabled = 1
let g:lsp_fold_enabled = 0
let g:lsp_text_edit_enabled = 1
let g:asyncomplete_auto_popup = 1
let g:asyncomplete_auto_completeopt = 1
let g:asyncomplete_popup_delay = 200
