UsePlugin 'vim-lsp'
UsePlugin 'asyncomplete.vim'
UsePlugin 'asyncomplete-lsp.vim'

let g:lsp_use_lua = (has('lua') && has('patch-8.2.0775'))
let g:lsp_async_completion = 1
let g:lsp_auto_enable = 1
let g:lsp_preview_keep_focus = 1
let g:lsp_preview_float = 1
let g:lsp_preview_autoclose = 1
let g:lsp_preview_doubletap = 0
let g:lsp_insert_text_enabled = 1
let g:lsp_text_edit_enabled = 1
let g:lsp_completion_documentation_enabled = 1
let g:lsp_completion_documentation_delay = 0
let g:lsp_diagnostics_enabled = 0
let g:lsp_diagnostics_echo_cursor = 0
" let g:lsp_diagnostics_echo_delay = 200
let g:lsp_diagnostics_float_cursor = 1
let g:lsp_diagnostics_float_delay = 200
let g:lsp_format_sync_timeout = -1
let g:lsp_diagnostics_highlights_insert_mode_enabled = 0
let g:lsp_diagnostics_highlights_enabled = 1
" let g:lsp_diagnostics_highlights_delay = 200
let g:lsp_diagnostics_signs_enabled = 1
let g:lsp_diagnostics_signs_insert_mode_enabled = 1
let g:lsp_diagnostics_signs_delay = 200
let g:lsp_diagnostics_signs_priority = 11
let g:lsp_diagnostics_virtual_text_enabled = 1
let g:lsp_diagnostics_virtual_text_insert_mode_enabled = 0
let g:lsp_diagnostics_virtual_text_delay = 200
let g:lsp_document_code_action_signs_enabled = 0
" let g:lsp_document_code_action_signs_delay = 200
let g:lsp_use_event_queue = 1
let g:lsp_document_highlight_enabled = 1
let g:lsp_document_highlight_delay = 200
let g:lsp_signature_help_enabled = 1
let g:lsp_signature_help_delay = 500
let g:lsp_show_workspace_edits = 0
let g:lsp_fold_enabled = 0
let g:lsp_hover_conceal = 1
let g:lsp_log_verbose = 0
let g:lsp_semantic_enabled = 0
let g:lsp_text_document_did_save_delay = 100
let g:lsp_completion_resolve_timeout = 0
let g:lsp_show_message_request_enabled = 0
let g:lsp_untitled_buffer_enabled = 0

let g:asyncomplete_auto_popup = 1
let g:asyncomplete_auto_completeopt = 1
let g:asyncomplete_popup_delay = 200

if FindPlugin('asyncomplete-buffer.vim')
  call asyncomplete#register_source(asyncomplete#sources#buffer#get_source_options({
    \ 'name': 'buffer',
    \ 'allowlist': ['*'],
    \ 'completor': function('asyncomplete#sources#buffer#completor'),
    \ 'priority': 9,
    \ 'config': {
    \    'max_buffer_size': 5000000,
    \  },
    \ }))
endif

if FindPlugin('asyncomplete-around.vim')
  call asyncomplete#register_source(asyncomplete#sources#around#get_source_options({
    \ 'name': 'around',
    \ 'allowlist': ['*'],
    \ 'priority': 10,
    \ 'completor': function('asyncomplete#sources#around#completor'),
    \ }))
endif

function! s:on_lsp_buffer_enabled() abort
  setlocal omnifunc=lsp#complete
  setlocal signcolumn=yes

  inoremap <expr> <cr> pumvisible() ? asyncomplete#close_popup() : "\<cr>"

  nmap <buffer> gd <plug>(lsp-peek-definition)
  nmap <buffer> gD <plug>(lsp-definition)
  " nmap <buffer> [g <plug>(lsp-previous-diagnostic)
  " nmap <buffer> ]g <plug>(lsp-next-diagnostic)
  nmap <buffer> <S-k> <plug>(lsp-hover)
  nnoremap <buffer> <expr><c-d> lsp#scroll(+8)
  nnoremap <buffer> <expr><c-f> lsp#scroll(-8)
endfunction

augroup lsp_install
  autocmd!
  autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
augroup END
