" Location:     autoload/ugbi.vim
" Maintainer:   Mike Smith

" The functions contained within this file are for internal use only.
" Folder in which script resides: (not safe for symlinks)
let s:path = expand('<sfile>:p:h')

if exists('g:autoloaded_ugbi')
  finish
endif
let g:autoloaded_ugbi = 1


function! ugbi#SamlFileType() abort
  set syntax=saml  
endfunction


function! ugbi#ShowSam(key)
  if &ft=='saml'
    return ''
  endif

  let g:prev_char = get(g:, "prev_char", v:null)
  let s:ugbi_repeat_count = get(s:, "ugbi_repeat_count", 1)

  let s:ugbi_repeat_count += 1
  let g:ugbi_msg = get(g:, "ugbi_msg", v:null)

  echohl Normal
  if a:key == g:prev_char
    if s:ugbi_repeat_count >= 41
      echohl ErrorMsg
      let g:ugbi_msg = printf("Say '%s' again, I dare you!", a:key)
    elseif s:ugbi_repeat_count >= 30
      echohl WarningMsg
      let g:ugbi_msg = printf("Say '%s' again, I dare you!", a:key)
    elseif s:ugbi_repeat_count >= 20
      echohl Question
      let g:ugbi_msg = printf("Say '%s' again!", a:key)
    elseif s:ugbi_repeat_count >= 15
      let g:ugbi_msg = printf("Say '%s' again", a:key)
    endif
    if s:ugbi_repeat_count >= 15
      echo g:ugbi_msg
    endif
  else
    " clear previous message and reset count
    if g:ugbi_msg != v:null
      let g:ugbi_msg = v:null  
      echo ''
    endif
    let s:ugbi_repeat_count = 1
  endif
  echohl Normal

  let g:prev_char = a:key

  if s:ugbi_repeat_count >= 42
    execute 'silent! tab new'
    set modifiable
    setlocal buftype=nofile
    setlocal bufhidden=wipe
    setlocal noswapfile
    setlocal shortmess=a
    call append(line("."),   repeat([""], winheight(0) - 1))
    execute "silent! ".winheight(0)."r" s:path."/../resources/sam.txt"
    execute 0
    let s:ugbi_repeat_count = 0
    redraw
    silent! file ugbi.saml
    execute 'silent! /\%1c\S'
    execute 'silent! /Sam was here'
    let c = 0
    while c <= 80
      execute 'normal! j'
      execute 'sleep 20ms'
      let c +=1
      redraw
    endwhile
    normal! H
    silent! help UserGettingBored | wincmd J | resize 4 | wincmd p
    call popup_create(printf("Say '%s' again. Say '%s' one more time!", a:key, a:key), #{
          \ line: "cursor",
          \ col: 20 ,
          \ time: 5000,
          \ minwidth: 10,
          \ tabpage: 0,
          \ zindex: 300,
          \ drag: 1,
          \ highlight: 'Question',
          \ border: [],
          \ close: 'button',
          \ padding: [4,5,4,5],
          \ })
    redraw
    set nomodifiable

    return ''
  endif
  return a:key
endfunction

function ugbi#SayOneMoreTime()
  let g:ugbi_more = 0
  let g:ugbi_more = confirm(printf("Say '%s' one more time? (Press CTRL-C to abort)", g:prev_char), printf("Say '&%s' one more time!", g:prev_char), 0,  "Error")
endfunction

" vim: set shiftwidth=2 tabstop=2 softtabstop=0:

