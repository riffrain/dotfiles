UsePlugin 'vim-lsp'
UsePlugin 'asyncomplete.vim'
UsePlugin 'asyncomplete-lsp.vim'

let g:asyncomplete_auto_popup = 1
let g:asyncomplete_auto_completeopt = 1
let g:asyncomplete_popup_delay = 500

let g:lsp_async_completion = 1
let g:lsp_auto_enable = 1
let g:lsp_preview_keep_focus = 1
let g:lsp_preview_float = 1
let g:lsp_preview_autoclose = 1
let g:lsp_preview_doubletap = 0
let g:lsp_insert_text_enabled = 1
let g:lsp_text_edit_enabled = 1
let g:lsp_completion_documentation_enabled = 1
let g:lsp_completion_documentation_delay = 500
if FindPlugin('ale')
  let g:lsp_diagnostics_enabled = 0
else
  let g:lsp_diagnostics_enabled = 1
endif
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

function! s:my_asyncomplete_preprocessor(options, matches) abort
  let l:visited = {}
  let l:items = []
  for [l:source_name, l:matches] in items(a:matches)
    for l:item in l:matches['items']
      if stridx(l:item['word'], a:options['base']) == 0
        if !has_key(l:visited, l:item['word'])
          call add(l:items, l:item)
          let l:visited[l:item['word']] = 1
        endif
      endif
    endfor
  endfor

  call asyncomplete#preprocess_complete(a:options, l:items)
endfunction

function! s:sort_by_priority_preprocessor(options, matches) abort
  let l:items = []
  for [l:source_name, l:matches] in items(a:matches)
    for l:item in l:matches['items']
      if stridx(l:item['word'], a:options['base']) == 0
        let l:item['priority'] =
            \ get(asyncomplete#get_source_info(l:source_name),'priority',0)
        call add(l:items, l:item)
      endif
    endfor
  endfor

  let l:items = sort(l:items, {a, b -> b['priority'] - a['priority']})

  call asyncomplete#preprocess_complete(a:options, l:items)
endfunction

let g:asyncomplete_preprocessor = [function('s:sort_by_priority_preprocessor')]

function! s:on_asyncomplete_setup() abort
  if FindPlugin('asyncomplete-buffer.vim')
    call asyncomplete#register_source(asyncomplete#sources#buffer#get_source_options({
      \ 'name': 'buffer',
      \ 'allowlist': ['*'],
      \ 'completor': function('asyncomplete#sources#buffer#completor'),
      \ 'priority': 9,
      \ 'config': {
      \    'max_buffer_size': 1000000,
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
endfunction

function! s:on_lsp_buffer_enabled() abort
  setlocal omnifunc=lsp#complete
  setlocal signcolumn=yes

  inoremap <expr> <cr> pumvisible() ? asyncomplete#close_popup() : "\<cr>"

  nmap <buffer> gd <plug>(lsp-peek-definition)
  nmap <buffer> gD <plug>(lsp-definition)
  if g:lsp_diagnostics_enabled == 1
    nmap <buffer> [g <plug>(lsp-previous-diagnostic)
    nmap <buffer> ]g <plug>(lsp-next-diagnostic)
  endif
  nmap <buffer> <S-k> <plug>(lsp-hover)
  nnoremap <buffer> <expr><c-d> lsp#scroll(+8)
  nnoremap <buffer> <expr><c-f> lsp#scroll(-8)
endfunction

augroup lsp_asyncomplete
  autocmd!
  autocmd User asyncomplete_setup call s:on_asyncomplete_setup()
  autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
augroup END