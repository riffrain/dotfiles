fun! s:setLightlineColorscheme(name)
  if FindPlugin('lightline')
    let g:lightline.colorscheme = a:name
    call lightline#init()
    call lightline#colorscheme()
    call lightline#update()
  endif
endfun

" Plug 'ulwlu/elly.vim'
autocmd vimrc ColorScheme elly call s:setLightlineColorscheme('elly')

" Plug 'ayu-theme/ayu-vim'
let g:ayucolor = 'dark'
autocmd vimrc ColorScheme ayu call s:setLightlineColorscheme('ayu')

" Plug 'sainnhe/sonokai'
let g:sonokai_style = 'maia'
" let g:sonokai_enable_italic = 0
" let g:sonokai_diagnostic_text_highlight = 0
" let g:sonokai_diagnostic_line_highlight = 0
let g:sonokai_better_performance = 0
autocmd vimrc ColorScheme sonokai call s:setLightlineColorscheme('sonokai')

" Plug 'tomasiser/vim-code-dark'
" let g:codedark_italics = 1
autocmd vimrc ColorScheme codedark call s:setLightlineColorscheme('codedark')

" Plug 'patstockwell/vim-monokai-tasty'
" let g:vim_monokai_tasty_italic = 0
autocmd vimrc ColorScheme vim-monokai-tasty call s:setLightlineColorscheme('monokai_tasty')


" Plug 'Mangeshrex/everblush.vim'
autocmd vimrc ColorScheme everblush call s:setLightlineColorscheme('everblush')

" Plug 'crusoexia/vim-monokai'
let g:monokai_term_italic = 1
let g:monokai_gui_italic = 1
autocmd vimrc ColorScheme monokai call s:setLightlineColorscheme('monokai_pro')

if has('nvim')
  " Plug 'Mofiqul/vscode.nvim'
  let g:vscode_style = "dark"
  let g:vscode_transparent = 1
  let g:vscode_italic_comment = 1
  autocmd vimrc ColorScheme vscode call s:setLightlineColorscheme('codedark') " require 'tomasiser/vim-code-dark'

  " Plug 'tanvirtin/monokai.nvim'
  autocmd vimrc ColorScheme monokai_pro call s:setLightlineColorscheme('monokai_tasty')
endif

" Plug 'RRethy/nvim-base16' for neovim
" Plug 'chriskempson/base16-vim' for vim
autocmd vimrc ColorScheme base16-monokai call s:setLightlineColorscheme('monokai_tasty')

if has('nvim')
  colorscheme base16-monokai
else
  colorscheme base16-monokai
endif
