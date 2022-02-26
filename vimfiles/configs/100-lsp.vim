"
" Lsp Setting
" use ddc.vim
"
UsePlugin 'denops.vim'
UsePlugin 'ddc.vim'
UsePlugin 'pum.vim'
UsePlugin 'ddc-around'
UsePlugin 'ddc-matcher_head'
UsePlugin 'ddc-sorter_rank'
UsePlugin 'ddc-vim-lsp'
UsePlugin 'vim-lsp'
UsePlugin 'vim-lsp-settings'
UsePlugin 'ddc-buffer'

function! s:on_lsp_buffer_enabled() abort
  call ddc#custom#patch_buffer('sources', ['vim-lsp', 'around', 'buffer'])
  call ddc#custom#patch_buffer('completionMenu', 'pum.vim')
  call ddc#custom#patch_buffer('sourceOptions', {
        \ '_': {
        \   'matchers': ['matcher_head'],
        \   'sorters': ['sorter_rank']},
        \ 'vim-lsp': {
        \   'matchers': ['matcher_head'],
        \   'mark': 'lsp'},
        \ 'buffer': {'mark': 'buffer'},
        \ 'around': {
        \   'maxSize': 500,
        \   'mark': 'around'},
        \ })
  call ddc#custom#patch_buffer('sourceParams', {
      \ 'buffer': {
      \   'requireSameFiletype': v:false,
      \   'limitBytes': 5000000,
      \   'fromAltBuf': v:true,
      \   'forceCollect': v:true,
      \ },
      \ 'ale': {
      \   'cleanResultsWhitespace': v:false,
      \ },
      \ })
  call ddc#custom#patch_buffer('autoCompleteEvents', [
      \ 'InsertEnter', 'TextChangedI', 'TextChangedP',
      \ 'CmdlineEnter', 'CmdlineChanged',
      \ ])

  " Use ddc.
  call ddc#enable()

  if FindPlugin('denops-signature_help')
    " Use signature_help
    let g:signature_help_config = {
        \ 'border': v:true,
        \ 'maxWidth': 80,
        \ 'maxHeight': 30,
        \ 'style': "full",
        \ 'onTriggerChar': v:false,
        \ 'multiLabel': v:false,
        \ }
    let g:lsp_signature_help_enabled = 0
    call signature_help#enable()
  endif

  if FindPlugin('denops-popup-preview.vim')
    call popup_preview#enable()
  endif

  imap <buffer> <silent><expr> <C-n>
    \ pum#visible() ? '<Cmd>call pum#map#insert_relative(+1)<CR>' :
    \ (col('.') <= 1 <Bar><Bar> getline('.')[col('.') - 2] =~# '\s') ?
    \ '' : ddc#manual_complete()
  imap <buffer> <C-p>   <Cmd>call pum#map#insert_relative(-1)<CR>
  imap <buffer> <C-y>   <Cmd>call pum#map#confirm()<CR>
  imap <buffer> <C-e>   <Cmd>call pum#map#cancel()<CR>

  nmap <buffer> gd <plug>(lsp-peek-definition)
  nmap <buffer> gD <plug>(lsp-definition)
  nmap <buffer> gs <plug>(lsp-document-symbol-search)
  nmap <buffer> gS <plug>(lsp-document-workspace-search)
  nmap <buffer> gr <plug>(lsp-references)
  nmap <buffer> [g <plug>(lsp-previous-diagnostic)
  nmap <buffer> ]g <plug>(lsp-next-diagnostic)
  nmap <buffer> gf <plug>(lsp-document-format)
  vmap <buffer> gf <plug>(lsp-document-range-format)
  nmap <buffer> <S-k> <plug>(lsp-hover)
  nnoremap <buffer> <expr><c-d> lsp#scroll(+8)
  nnoremap <buffer> <expr><c-f> lsp#scroll(-8)
endfunction

let g:lsp_completion_documentation_enabled = 1
let g:lsp_completion_documentation_delay = 50
let g:lsp_diagnostics_enabled = 1
let g:lsp_diagnostics_echo_cursor = 0
let g:lsp_diagnostics_echo_delay = 50
let g:lsp_diagnostics_float_cursor = 1
let g:lsp_diagnostics_float_delay = 1000
let g:lsp_semantic_enabled = 1
let g:lsp_fold_enabled = 0

augroup lsp_install
  au!
  autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
augroup END
