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
UsePlugin 'denops-signature_help'
UsePlugin 'denops-popup-preview.vim'

call ddc#custom#patch_global('sources', ['vim-lsp', 'around', 'buffer'])
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
      \ })
call ddc#custom#patch_global('sourceParams', {
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
call ddc#custom#patch_global('autoCompleteEvents', [
    \ 'InsertEnter', 'TextChangedI', 'TextChangedP',
    \ 'CmdlineEnter', 'CmdlineChanged',
    \ ])

" Mappings
inoremap <silent><expr> <C-n>
      \ pum#visible() ? '<Cmd>call pum#map#insert_relative(+1)<CR>' :
      \ (col('.') <= 1 <Bar><Bar> getline('.')[col('.') - 2] =~# '\s') ?
      \ '' : ddc#manual_complete()
inoremap <C-p>   <Cmd>call pum#map#insert_relative(-1)<CR>
inoremap <C-y>   <Cmd>call pum#map#confirm()<CR>
inoremap <C-e>   <Cmd>call pum#map#cancel()<CR>

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
