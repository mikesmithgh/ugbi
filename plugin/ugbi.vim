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
  fi
  for key in s:keys
    execute printf('inoremap <silent> %s <C-r>=ugbi#ShowSam("%s")<CR>', key, key)
  endfor
endfunction

function UgbiDisable()
  let l:keys = get(s:, "keys", [])
  for key in l:keys
    execute 'iunmap ' . key
  endfor
  let s:keys = []
endfunction


augroup ugbi
  autocmd!
  autocmd CursorHold *.saml execute 'call ugbi#SayOneMoreTime()'
augroup end

execute 'command! UgbiEnable call UgbiEnable()'
execute 'command! UgbiDisable call UgbiDisable()'

call UgbiEnable()

" vim: set shiftwidth=2 tabstop=2 softtabstop=0:

