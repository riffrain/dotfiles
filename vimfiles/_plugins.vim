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

  " git
  Plug 'airblade/vim-gitgutter'
  Plug 'tpope/vim-fugitive'

  " finder
  Plug 'ctrlpvim/ctrlp.vim'
  Plug 'mattn/ctrlp-matchfuzzy'
  Plug 'mhinz/vim-grepper', { 'on': ['Grepper', '<plug>(GrepperOperator)'] }
  Plug 't9md/vim-choosewin'
  Plug 'preservim/nerdtree'

  " LSP & completion
  Plug 'prabirshrestha/asyncomplete.vim'
  " Plug 'prabirshrestha/asyncomplete-buffer.vim'
  " Plug 'akaimo/asyncomplete-around.vim'
  " Plug 'yami-beta/asyncomplete-omni.vim'
  Plug 'prabirshrestha/asyncomplete-lsp.vim'
  Plug 'prabirshrestha/vim-lsp'
  Plug 'mattn/vim-lsp-settings'
  " Plug 'neoclide/coc.nvim', {'branch': 'release'}

  " snippets
  Plug 'mattn/vim-sonictemplate'
  " Plug 'hrsh7th/vim-vsnip'
  " Plug 'hrsh7th/vim-vsnip-integ'
  " Plug 'rafamadriz/friendly-snippets'

  " linter
  Plug 'dense-analysis/ale'
  " Plug 'vim-syntastic/syntastic'
call plug#end()

" Auto install plugins
autocmd vimrc VimEnter * if len(filter(values(g:plugs), '!isdirectory(v:val.dir)')) | PlugInstall --sync | q | endif
let s:plugs = get(s:, 'plugs', get(g:, 'plugs', {}))
function! FindPlugin(name) abort
  return has_key(s:plugs, a:name) ? isdirectory(s:plugs[a:name].dir) : 0
endfunction
command! -nargs=1 UsePlugin if !FindPlugin(<args>) | finish | endif

runtime! _configs/*.vim
