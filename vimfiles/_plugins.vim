call plug#begin('~/.vim/plugged')
  Plug 'ayu-theme/ayu-vim'
  Plug 'Erichain/vim-monokai-pro'
  Plug 'sainnhe/sonokai'
  Plug 'Mangeshrex/everblush.vim'
  Plug 'tomasiser/vim-code-dark'
  Plug 'patstockwell/vim-monokai-tasty'
  Plug 'mhinz/vim-janah'
  Plug 'ulwlu/elly.vim'

  Plug 'sheerun/vim-polyglot'

  Plug 'itchyny/lightline.vim'
  Plug 'itchyny/vim-cursorword'

  Plug 'editorconfig/editorconfig-vim'

  Plug 'easymotion/vim-easymotion'

  Plug 'airblade/vim-gitgutter'

  Plug 'tpope/vim-repeat'

  Plug 'cohama/lexima.vim'
  Plug 'wellle/targets.vim'
  Plug 'tpope/vim-unimpaired'
  Plug 'tpope/vim-fugitive'
  Plug 'tpope/vim-surround'
  Plug 'Matt-A-Bennett/vim-surround-funk'
  Plug 'AndrewRadev/splitjoin.vim'

  Plug 'ctrlpvim/ctrlp.vim'
  Plug 'mattn/ctrlp-matchfuzzy'
  Plug 'mhinz/vim-grepper', { 'on': ['Grepper', '<plug>(GrepperOperator)'] }

  Plug 't9md/vim-choosewin'
  Plug 'preservim/nerdtree'

  Plug 'mattn/vim-sonictemplate'
  Plug 'mattn/vim-findroot'

  Plug 'prabirshrestha/asyncomplete.vim'
  " Plug 'prabirshrestha/asyncomplete-buffer.vim'
  " Plug 'akaimo/asyncomplete-around.vim'
  Plug 'prabirshrestha/asyncomplete-lsp.vim'
  Plug 'prabirshrestha/vim-lsp'
  Plug 'mattn/vim-lsp-settings'

  " Plug 'hrsh7th/vim-vsnip'
  " Plug 'hrsh7th/vim-vsnip-integ'
  " Plug 'rafamadriz/friendly-snippets'

  " Plug 'dense-analysis/ale'
  " Plug 'vim-syntastic/syntastic'

  " Plug 'neoclide/coc.nvim', {'branch': 'release'}
call plug#end()

" Auto install plugins
autocmd vimrc VimEnter * if len(filter(values(g:plugs), '!isdirectory(v:val.dir)')) | PlugInstall --sync | q | endif
let s:plugs = get(s:, 'plugs', get(g:, 'plugs', {}))
function! FindPlugin(name) abort
  return has_key(s:plugs, a:name) ? isdirectory(s:plugs[a:name].dir) : 0
endfunction
command! -nargs=1 UsePlugin if !FindPlugin(<args>) | finish | endif

runtime! _configs/*.vim
