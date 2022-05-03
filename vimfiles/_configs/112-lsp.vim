UsePlugin 'LanguageClient-neovim'

let g:LanguageClient_serverCommands = {
    \ 'php': [ 'phpactor', 'server:start', '--stdio']
    \}

inoremap <expr> <CR> pumvisible() ? "\<c-y>\<cr>" : "\<CR>"
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

nnoremap <silent> K :call LanguageClient#textDocument_hover()<CR>
nnoremap <silent> gd :call LanguageClient#textDocument_definition()<CR>
