call plug#begin('~/.vim/plugged')
  " colorscheme
  Plug 'sainnhe/sonokai'
  Plug 'patstockwell/vim-monokai-tasty'
  if has('nvim')
    Plug 'tanvirtin/monokai.nvim'
    " Plug 'Mofiqul/vscode.nvim' | Plug 'tomasiser/vim-code-dark'
  else
    Plug 'Erichain/vim-monokai-pro'
    " Plug 'tomasiser/vim-code-dark'
  endif
  " Plug 'ayu-theme/ayu-vim'
  " Plug 'Mangeshrex/everblush.vim'
  " Plug 'ulwlu/elly.vim'
  " Plug 'tomasr/molokai'
  " Plug 'jacoborus/tender.vim'
  " Plug 'preservim/vim-colors-pencil'

  " statusline
  Plug 'itchyny/lightline.vim'

  " edit support
  Plug 'editorconfig/editorconfig-vim'
  Plug 'itchyny/vim-cursorword'
  Plug 'easymotion/vim-easymotion'
  Plug 'tpope/vim-repeat'
  Plug 'cohama/lexima.vim'
  Plug 'tpope/vim-unimpaired'
  Plug 'tpope/vim-surround'
  Plug 'AndrewRadev/splitjoin.vim', { 'on': ['SplitjoinJoin', 'SplitjoinSplit', '<plug>SplitjoinJoin', '<plug>SplitjoinSplit'] }
  Plug 'mattn/vim-findroot'
  " Plug 'wellle/targets.vim'
  " Plug 'Matt-A-Bennett/vim-surround-funk'
  " Plug 'rhysd/clever-f.vim'

  " git
  Plug 'airblade/vim-gitgutter'
  Plug 'tpope/vim-fugitive'
  Plug 'rhysd/git-messenger.vim', { 'on': ['GitMessenger', '<plug>(git-messenger)'] }

  " finder
  Plug 'ctrlpvim/ctrlp.vim', { 'on': ['CtrlP', 'CtrlPLine', 'CtrlPBuffer', 'CtrlPMixed'] }
  Plug 'mattn/ctrlp-matchfuzzy', { 'on': ['CtrlP', 'CtrlPLine', 'CtrlPBuffer', 'CtrlPMixed'] }
  Plug 'mhinz/vim-grepper', { 'on': ['Grepper', '<plug>(GrepperOperator)'] }
  Plug 't9md/vim-choosewin', { 'on': ['<plug>(choosewin)', 'NERDTree', 'NERDTreeToggle'] }
  Plug 'preservim/nerdtree', { 'on': ['NERDTree', 'NERDTreeToggle'] }

  " snippets
  Plug 'mattn/vim-sonictemplate', { 'on': ['<plug>(sonictemplate-postfix)'] }

  " syntax
  if has('nvim')
    Plug 'nvim-treesitter/nvim-treesitter', { 'do': ':TSUpdate' }
  else
    Plug 'sheerun/vim-polyglot'
    if executable('go')
      Plug 'mattn/vim-treesitter', { 'branch': 'main' }
    endif
  endif

  " LSP
  " Plug 'neoclide/coc.nvim', {'branch': 'release'}
  if has('nvim')
    Plug 'neovim/nvim-lspconfig'
    Plug 'williamboman/nvim-lsp-installer'

    Plug 'hrsh7th/nvim-cmp'
    Plug 'hrsh7th/cmp-nvim-lsp'
    Plug 'hrsh7th/cmp-nvim-lsp-signature-help'
    Plug 'hrsh7th/cmp-vsnip'
    Plug 'hrsh7th/vim-vsnip'
    Plug 'hrsh7th/vim-vsnip-integ'
    Plug 'rafamadriz/friendly-snippets'
    Plug 'hrsh7th/cmp-buffer'
    Plug 'hrsh7th/cmp-path'
    Plug 'hrsh7th/cmp-cmdline'
    Plug 'tzachar/cmp-tabnine', { 'do': './install.sh' }
  endif

  if executable('php') && executable('composer')
    Plug 'phpactor/phpactor', { 'for': 'php', 'branch': 'master', 'do': 'composer install --no-dev -o' }
  endif

  " linter
  if !has('nvim')
    Plug 'vim-syntastic/syntastic'
  endif
  " Plug 'dense-analysis/ale'
  " Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }

  if has('nvim')
    Plug 'folke/trouble.nvim'
    Plug 'simrat39/symbols-outline.nvim'
    " Plug 'nvim-lua/plenary.nvim'
    " Plug 'nvim-telescope/telescope.nvim'
  else
    " Plug 'prabirshrestha/asyncomplete.vim'
    " Plug 'prabirshrestha/asyncomplete-buffer.vim'
    " Plug 'akaimo/asyncomplete-around.vim'
    " Plug 'yami-beta/asyncomplete-omni.vim'
    " Plug 'prabirshrestha/asyncomplete-lsp.vim'
    " Plug 'prabirshrestha/vim-lsp'
    " Plug 'mattn/vim-lsp-settings'
  endif
call plug#end()

" Auto install plugins
autocmd vimrc VimEnter * if len(filter(values(g:plugs), '!isdirectory(v:val.dir)')) | PlugInstall --sync | q | endif
let s:plugs = get(s:, 'plugs', get(g:, 'plugs', {}))
function! FindPlugin(name) abort
  return has_key(s:plugs, a:name) ? isdirectory(s:plugs[a:name].dir) : 0
endfunction
command! -nargs=1 UsePlugin if !FindPlugin(<args>) | finish | endif

runtime! _configs/*.vim
