
if FindPlugin('ayu-vim')
  let g:lightline.colorscheme = 'ayu'
  let g:ayucolor = 'dark'

  colorscheme ayu
  finish
endif

if FindPlugin('sonokai')
  let g:sonokai_style = 'default'
  let g:sonokai_enable_italic = 1
  let g:sonokai_diagnostic_text_highlight = 1
  let g:sonokai_diagnostic_line_highlight = 1
  let g:sonokai_better_performance = 0
  let g:lightline.colorscheme = 'sonokai'

  colorscheme sonokai
  finish
endif

if FindPlugin('vim-code-dark')
  let g:codedark_italics = 1
  let g:lightline.colorscheme = 'codedark'

  colorscheme codedark
  finish
endif

if FindPlugin('vim-monokai-tasty')
  let g:lightline.colorscheme = 'monokai_tasty'
  let g:vim_monokai_tasty_italic = 1

  colorscheme vim-monokai-tasty
  finish
endif


if FindPlugin('everblush.vim')
  let g:lightline.colorscheme = 'everblush'

  colorscheme everblush
  finish
endif

if FindPlugin('vim-monokai-pro')
  let g:lightline.colorscheme = 'monokai_pro'

  colorscheme monokai_pro
  finish
endif
