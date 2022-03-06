"
" colorscheme
"

let g:vim_monokai_tasty_italic = 1
let g:codedark_italics = 1

if FindPlugin('sonokai')
  let g:sonokai_style = 'espresso'
  let g:sonokai_enable_italic = 1
  let g:sonokai_diagnostic_text_highlight = 1
  let g:sonokai_diagnostic_line_highlight = 1
  let g:sonokai_better_performance = 0

  colorscheme sonokai
  finish
endif

if FindPlugin('vim-code-dark')
  colorscheme codedark
  finish
endif

if FindPlugin('vim-monokai-tasty')
  colorscheme vim-monokai-tasty
  finish
endif

if FindPlugin('everblush.vim')
  colorscheme everblush
  finish
endif

if FindPlugin('ayu-vim')
  colorscheme ayu
  finish
endif

if FindPlugin('vim-monokai-pro')
  colorscheme monokai_pro
  finish
endif
