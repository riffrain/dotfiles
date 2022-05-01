" aug hoge
"   au!
"   nnoremap <Leader>kk call PhpactorHover()<CR>
" aug END

let s:popup = {}

function! s:popup__get_winnr() dict abort
    if !has_key(self, 'bufnr')
        return 0
    endif

    " Note: bufwinnr() is not available here because there may be multiple
    " windows which open the buffer. This situation happens when enter <C-w>v
    " in popup window. It opens a new normal window with the popup's buffer.
    return win_id2win(self.win_id)
endfunction
let s:popup.get_winnr = funcref('s:popup__get_winnr')

function! s:popup__close() dict abort
    if !has_key(self, 'bufnr')
        " Already closed
        return
    endif

    let winnr = self.get_winnr()
    if winnr > 0
        " Without this 'noautocmd', the BufWipeout event will be triggered and
        " this function will be called again.
        noautocmd execute winnr . 'wincmd c'
    endif

    unlet self.bufnr
    unlet self.win_id

    " if has_key(self.opts, 'did_close')
    "     call self.opts.did_close(self)
    " endif
endfunction
let s:popup.close = funcref('s:popup__close')

function! s:pop() dict abort
    let self.opener_bufnr = bufnr('%')
    let self.opener_winid = win_getid()

    let self.type = 'floating'

  " 開くウィンドウの幅
  let width = 100

  " 開くウィンドウの高さ
  let height = 3

  " ウィンドウを開いたあと，カーソルをそのウィンドウ内に移動するか
  let enter = v:true

  " 何に対して相対的にウィンドウの配置位置を決めるか
  "   - "editor": エディタのスクリーンに対して．スクリーン上の絶対座標で指定
  "   - "win": 現在のウィンドウ位置に対して．これを使う場合はオプションに 'win' というキーで別途対象ウィンドウのウィンドウ ID を指定する
  "   - "cursor": カーソル位置に対して
  let relative = 'cursor'

  " 基準となるウィンドウの角を四隅のどこにするかを指定します（デフォルト "NW"）
  "   - "NW": 左上
  "   - "NE": 右上
  "   - "SE": 右下
  "   - "SW": 左下
  let anchor = 'NW'

  " 'relative' で指定した位置に対する相対的なオフセット
  let row = 1
  let col = 0

  " Neovim 内ではなく，GUI フロントエンド側にウィンドウを出すよう依頼するか
  let external = v:false

  let request = { "action": "hover", "parameters": { "offset": phpactor#_offset(), "source": phpactor#_source() } }


  execute ':redraw'

  let l:workspaceDir = phpactor#getRootDirectory()

  " note that we should escape these arguments, but using the list syntax
  " here causes tests to fail on travis with VIM 8.3 ...
  let l:cmd = g:phpactorPhpBin . ' ' . g:phpactorbinpath . ' rpc --working-dir=' . l:workspaceDir

  let result = system(l:cmd, json_encode(request))

  if (v:shell_error == 0)
      try
          let response = json_decode(result)
      catch
          throw "Could not parse response from Phpactor: " . v:exception
      endtry

      let actionName = response['action']
      let parameters = extend(copy(response['parameters']), a:0 ? a:1 : {})

      if actionName == 'echo'
        let win_id = nvim_open_win(bufnr('%'), enter, {
            \   'width': width,
            \   'height': height,
            \   'relative': relative,
            \   'anchor': anchor,
            \   'row': row,
            \   'col': col,
            \   'external': external,
            \})

        enew!
        let popup_bufnr = bufnr('%')
        setlocal
        \ buftype=nofile bufhidden=wipe nomodified nobuflisted noswapfile nonumber
        \ nocursorline wrap nonumber norelativenumber signcolumn=no nofoldenable
        \ nospell nolist nomodeline conceallevel=2
        call setline('.', [parameters['message']])
        setlocal nomodified nomodifiable

        let b:__popup = self
        execute 'autocmd BufWipeout,BufLeave <buffer> call getbufvar(' . popup_bufnr . ', "__popup").close()'

        aug Hoge
          au!
          autocmd CursorMoved,CursorMovedI,InsertEnter <buffer> ++once call s:popup.close()<CR>
        aug END

        noautocmd wincmd p

        let self.bufnr = popup_bufnr
        let self.win_id = win_id
      endif

      " let response = phpactor#_rpc_dispatch(actionName, parameters)
      " if !empty(response)
      "     return response
      " endif
  else
      echo "Phpactor returned an error: " . result
      return
  endif
endfunction
let s:popup.open = funcref('s:pop')

command! -buffer -nargs=0 MyPhpactorHover call s:popup.open()
nnoremap <Leader>kk :MyPhpactorHover<CR>
