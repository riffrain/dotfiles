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
UsePlugin 'ddc-cmdline'
UsePlugin 'ddc-ale'
UsePlugin 'denops-signature_help'
UsePlugin 'denops-popup-preview.vim'

call ddc#custom#patch_global('sources', ['vim-lsp', 'around', 'buffer', 'ale'])
call ddc#custom#patch_global('completionMenu', 'pum.vim')
call ddc#custom#patch_global('sourceOptions', {
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
      \ 'ale': { 'mark': 'ale' },
      \ })
call ddc#custom#patch_global('sourceParams', {
    \ 'buffer': {
    \   'requireSameFiletype': v:false,
    \   'limitBytes': 500,
    \   'fromAltBuf': v:true,
    \   'forceCollect': v:true,
    \ },
    \ 'ale': {
    \   'cleanResultsWhitespace': v:false,
    \ },
    \ })
call ddc#custom#patch_global('autoCompleteEvents', [
    \ 'InsertEnter', 'TextChangedI', 'TextChangedP',
    \ 'CmdlineEnter', 'CmdlineChanged',
    \ ])


function! CommandlinePost() abort
  " Restore sources
  call ddc#custom#set_buffer(s:prev_buffer_config)
  cunmap <Tab>
endfunction

function! CommandlinePre() abort
  cnoremap <expr> <Tab>
    \ pum#visible() ? '<Cmd>call pum#map#insert_relative(+1)<CR>' :
    \ ddc#manual_complete()
  cnoremap <S-Tab> <Cmd>call pum#map#insert_relative(-1)<CR>
  cnoremap <C-n>   <Cmd>call pum#map#insert_relative(+1)<CR>
  cnoremap <C-p>   <Cmd>call pum#map#insert_relative(-1)<CR>
  cnoremap <C-y>   <Cmd>call pum#map#confirm()<CR>
  cnoremap <C-e>   <Cmd>call pum#map#cancel()<CR>

  let s:prev_buffer_config = ddc#custom#get_buffer()
  call ddc#custom#patch_buffer('sources', ['cmdline', 'around'])

  autocmd User DDCCmdlineLeave ++once call CommandlinePost()

  call ddc#enable_cmdline_completion()
  call ddc#enable()
endfunction

" Mappings

inoremap <silent><expr> <C-n>
      \ pum#visible() ? '<Cmd>call pum#map#insert_relative(+1)<CR>' :
      \ (col('.') <= 1 <Bar><Bar> getline('.')[col('.') - 2] =~# '\s') ?
      \ '' : ddc#manual_complete()
inoremap <C-p>   <Cmd>call pum#map#insert_relative(-1)<CR>
inoremap <C-y>   <Cmd>call pum#map#confirm()<CR>
inoremap <C-e>   <Cmd>call pum#map#cancel()<CR>
" nnoremap : <Cmd>call CommandlinePre()<CR>:

" Use ddc.
call ddc#enable()

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
call popup_preview#enable()