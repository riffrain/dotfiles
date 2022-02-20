"
" colorscheme
"

if FindPlugin('vim-monokai-tasty')
  let g:vim_monokai_tasty_italic = 1
  colorscheme vim-monokai-tasty
  finish
end

if FindPlugin('vim-code-dark')
  let g:codedark_italics = 1
  colorscheme codedark
  finish
endif

if FindPlugin('everblush.vim')
  colorscheme everblush
  finish
endif

if FindPlugin('ayu-vim')
  colorscheme ayu
  finish
end

if FindPlugin('sonokai')
  colorscheme sonokai
  finish
end

if FindPlugin('vim-monokai-pro')
  colorscheme monokai_pro
  finish
end
