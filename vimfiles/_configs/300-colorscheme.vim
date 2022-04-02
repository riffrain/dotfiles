let s:default_colorscheme = 'vim-monokai-tasty'

let s:lightline_colorschemes = {}
if FindPlugin('elly.vim')
  let s:lightline_colorschemes['elly'] = 'elly'
endif

if FindPlugin('ayu-vim')
  let s:lightline_colorschemes['ayu'] = 'ayu'
  let g:ayucolor = 'dark'
endif

if FindPlugin('sonokai')
  let g:sonokai_style = 'maia'
  let g:sonokai_enable_italic = 1
  let g:sonokai_diagnostic_text_highlight = 1
  let g:sonokai_diagnostic_line_highlight = 1
  let g:sonokai_better_performance = 0
  let s:lightline_colorschemes['sonokai'] = 'sonokai'
endif

if FindPlugin('vim-code-dark')
  let g:codedark_italics = 1
  let s:lightline_colorschemes['codedark'] = 'codedark'
endif

if FindPlugin('vim-monokai-tasty')
  let g:vim_monokai_tasty_italic = 1
  let s:lightline_colorschemes['vim-monokai-tasty'] = 'monokai_tasty'
endif


if FindPlugin('everblush.vim')
  let s:lightline_colorschemes['everblush'] = 'everblush'
endif

if FindPlugin('vim-monokai-pro')
  let s:lightline_colorschemes['monokai_pro'] = 'monokai_pro'
endif

if FindPlugin('vim-monokai')
  let g:monokai_term_italic = 1
  let g:monokai_gui_italic = 1
  let s:lightline_colorschemes['monokai'] = 'monokai_pro'
endif

if FindPlugin('vscode.nvim')
  let g:vscode_style = "dark"
  let g:vscode_transparent = 1
  let g:vscode_italic_comment = 1
  let s:lightline_colorschemes['vscode'] = 'codedark'
endif

let g:lightline.colorscheme = s:lightline_colorschemes[s:default_colorscheme]
silent! execute 'colorscheme ' . s:default_colorscheme
