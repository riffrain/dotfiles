let g:vim_monokai_tasty_italic = 1

let g:codedark_italics = 1

let g:sonokai_style = 'espresso'
let g:sonokai_enable_italic = 1
let g:sonokai_diagnostic_text_highlight = 1
let g:sonokai_diagnostic_line_highlight = 1
let g:sonokai_better_performance = 0

if FindPlugin('sonokai')
  colorscheme sonokai
  let g:lightline.colorscheme = 'sonokai'
  finish
endif

if FindPlugin('vim-code-dark')
  colorscheme codedark
  let g:lightline.colorscheme = 'codedark'
  finish
endif

if FindPlugin('vim-monokai-tasty')
  colorscheme vim-monokai-tasty
  let g:lightline.colorscheme = 'monokai_tasty'
  finish
endif

if FindPlugin('everblush.vim')
  colorscheme everblush
  let g:lightline.colorscheme = 'everblush'
  finish
endif

if FindPlugin('ayu-vim')
  colorscheme ayu
  let g:lightline.colorscheme = 'ayu'
  finish
endif

if FindPlugin('vim-monokai-pro')
  colorscheme monokai_pro
  let g:lightline.colorscheme = 'monokai_pro'
  finish
endif
