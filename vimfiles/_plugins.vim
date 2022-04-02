call plug#begin('~/.vim/plugged')
  " colorscheme
  Plug 'ayu-theme/ayu-vim'
  Plug 'Erichain/vim-monokai-pro'
  Plug 'sainnhe/sonokai'
  Plug 'Mangeshrex/everblush.vim'
  Plug 'tomasiser/vim-code-dark'
  Plug 'patstockwell/vim-monokai-tasty'
  Plug 'mhinz/vim-janah'
  Plug 'ulwlu/elly.vim'
  Plug 'tomasr/molokai'
  Plug 'crusoexia/vim-monokai'

  " syntax highlight
  Plug 'sheerun/vim-polyglot'

  " statusline
  Plug 'itchyny/lightline.vim'

  " edit support
  Plug 'itchyny/vim-cursorword'
  Plug 'editorconfig/editorconfig-vim'
  Plug 'easymotion/vim-easymotion'
  Plug 'tpope/vim-repeat'
  Plug 'cohama/lexima.vim'
  Plug 'wellle/targets.vim'
  Plug 'tpope/vim-unimpaired'
  Plug 'tpope/vim-surround'
  Plug 'Matt-A-Bennett/vim-surround-funk'
  Plug 'AndrewRadev/splitjoin.vim'
  Plug 'mattn/vim-findroot'
  Plug 'ap/vim-css-color'

  " git
  Plug 'airblade/vim-gitgutter'
  Plug 'tpope/vim-fugitive'

  " finder
  Plug 'ctrlpvim/ctrlp.vim'
  Plug 'mattn/ctrlp-matchfuzzy'
  Plug 'mhinz/vim-grepper', { 'on': ['Grepper', '<plug>(GrepperOperator)'] }
  Plug 't9md/vim-choosewin'
  Plug 'preservim/nerdtree'

  " snippets
  Plug 'mattn/vim-sonictemplate'
  " Plug 'hrsh7th/vim-vsnip'
  " Plug 'hrsh7th/vim-vsnip-integ'
  " Plug 'rafamadriz/friendly-snippets'

  if !has('nvim')
    " LSP & completion
    Plug 'prabirshrestha/asyncomplete.vim'
    " Plug 'prabirshrestha/asyncomplete-buffer.vim'
    " Plug 'akaimo/asyncomplete-around.vim'
    " Plug 'yami-beta/asyncomplete-omni.vim'
    Plug 'prabirshrestha/asyncomplete-lsp.vim'
    Plug 'prabirshrestha/vim-lsp'
    Plug 'mattn/vim-lsp-settings'
    " Plug 'neoclide/coc.nvim', {'branch': 'release'}

    " linter
    Plug 'dense-analysis/ale'
    " Plug 'vim-syntastic/syntastic'
  endif

  if has('nvim')
    Plug 'Mofiqul/vscode.nvim'

    Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

    Plug 'hrsh7th/nvim-cmp'
    Plug 'neovim/nvim-lspconfig'
    Plug 'hrsh7th/cmp-nvim-lsp'
    Plug 'hrsh7th/cmp-buffer'
    Plug 'hrsh7th/cmp-path'
    Plug 'hrsh7th/cmp-cmdline'
    Plug 'hrsh7th/cmp-vsnip'
    Plug 'hrsh7th/vim-vsnip'
    Plug 'hrsh7th/vim-vsnip-integ'
    Plug 'rafamadriz/friendly-snippets'
    Plug 'williamboman/nvim-lsp-installer'
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
