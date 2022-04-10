UsePlugin 'vim-choosewin'

nmap <Leader>- <Plug>(choosewin)
let g:choosewin_label='sdfghjklqwertyuioopzxcvbnm'
let g:choosewin_overlay_enable=1
let g:choosewin_overlay_clear_multibyte = 1
let g:choosewin_color_overlay = {
      \ 'gui': ['DodgerBlue3', 'DodgerBlue3' ],
      \ 'cterm': [ 25, 25 ]
      \ }
let g:choosewin_color_overlay_current = {
      \ 'gui': ['firebrick1', 'firebrick1' ],
      \ 'cterm': [ 124, 124 ]
      \ }
let g:choosewin_blink_on_land      = 0
let g:choosewin_statusline_replace = 0
let g:choosewin_tabline_replace    = 0
