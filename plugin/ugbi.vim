" ugbi.vim - UserGettingBoredImproved, a pointless plugin
" Maintainer: Mike Smith
" Version: 0.1
"

function! UgbiEnable()
  " Referenced https://github.com/vim-scripts/AutoComplPop/blob/master/autoload/acp.vim
  " Thank you Takeshi!
  call UgbiDisable()
  let l:enabled = get(g:, "ugbi_enabled", 1)
  if !l:enabled
    return
  endif
  let s:keys = [
        \ 'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm',
        \ 'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z',
        \ 'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M',
        \ 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z',
        \ '0', '1', '2', '3', '4', '5', '6', '7', '8', '9' ]
  for key in s:keys
    execute printf('inoremap <silent> %s <C-r>=ugbi#ShowSam("%s")<CR>', key, key)
  endfor
endfunction

function! UgbiDisable()
  let l:keys = get(s:, "keys", [])
  for key in l:keys
    execute 'iunmap ' . key
  endfor
  let s:keys = []
endfunction


augroup ugbi
  autocmd!
  autocmd CursorHold *.saml execute 'call ugbi#SayOneMoreTime(2)'
augroup end

execute 'command! UgbiEnable call UgbiEnable()'
execute 'command! UgbiDisable call UgbiDisable()'

if v:version >= 800
  call UgbiEnable()
else
  echomsg "Ugbi is not compatible with version ".v:version." of vim. Upgrade to version 8.0 or greater."
  let s:path = expand('<sfile>:p:h')
  let s:lines = readfile(s:path."/../plugin/sammy.ascii")
  for s:line in s:lines
    echo s:line
  endfor
endif

" vim: set shiftwidth=2 tabstop=2 softtabstop=0:

