" Location:     autoload/ugbi.vim
" Maintainer:   Mike Smith

" The functions contained within this file are for internal use only.
" Folder in which script resides: (not safe for symlinks)
let s:path = expand('<sfile>:p:h')

if exists('g:autoloaded_ugbi')
  finish
endif
let g:autoloaded_ugbi = 1

function! ugbi#ShowSam(key)
  " if already showing sam just return escape
  if &ft == 'saml'
    return ''
  endif

  let l:show_count = get(g:, "ugbi_show_count", 0)

  let s:prev_char = get(s:, "prev_char", v:null)
  let s:repeat_count = get(s:, "repeat_count", 1) + 1
  let s:msg = get(s:, "msg", v:null)

  if l:show_count
    let l:count_msg = printf("count(%s,%02d) ", a:key, s:repeat_count)
  else
    let l:count_msg = ''
  endif
  echohl Normal
  if a:key == s:prev_char
    if s:repeat_count >= 41
      echohl ErrorMsg
      let s:msg = printf("%sSay '%s' again, I dare you!", l:count_msg, a:key)
    elseif s:repeat_count >= 30
      echohl WarningMsg
      let s:msg = printf("%sSay '%s' again, I dare you!", l:count_msg, a:key)
    elseif s:repeat_count >= 20
      echohl Question
      let s:msg = printf("%sSay '%s' again!", l:count_msg, a:key)
    elseif s:repeat_count >= 15
      let s:msg = printf("%sSay '%s' again", l:count_msg, a:key)
    else
      let s:msg = l:count_msg
    endif
    if s:repeat_count >= 15 || l:show_count
      echo s:msg
    endif
  else
    " clear previous message and reset count
    if s:msg != v:null
      let s:msg = v:null  
      echo ''
    endif
    let s:repeat_count = 1
  endif
  echohl Normal

  let s:prev_char = a:key

  if s:repeat_count >= 42
    let s:repeat_count = 0

    silent! tabnew ugbi.saml
    setlocal modifiable

    " add whitespace to hide sam
    call append(line("."),   repeat([""], winheight(0) - 1))
    " copy sam into buffer and go back to top
    execute "silent! ".winheight(0)."r" s:path."/../resources/sam.txt | 0"
    redraw

    silent! /\%1c\S
    silent! /Sam is here
    let c = 0
    while c <= 80
      execute 'normal! j'
      execute 'sleep 20ms'
      let c +=1
      redraw
    endwhile
    normal! H

    let l:popup_msg=printf("Say '%s' again. Say '%s' one more time!%65s%28sUserGettingBored    When the user presses the same key 42 times.%21sJust kidding! :-)", a:key, a:key, '', '', '')
    call popup_create(l:popup_msg, #{
          \ line: "cursor",
          \ col: 10 ,
          \ time: 5000,
          \ minwidth: 65,
          \ maxwidth: 65,
          \ tabpage: 0,
          \ zindex: 300,
          \ drag: 1,
          \ highlight: 'WarningMsg',
          \ border: [],
          \ close: 'button',
          \ padding: [3,4,3,4],
          \ title: ' UserGettingBored ',
          \ })
    redraw
    setlocal nomodifiable

    return ''
  endif
  return a:key
endfunction

function! ugbi#SayOneMoreTime()
  let s:ugbi_more = 0
  try 
    let s:ugbi_more = confirm(printf("Say '%s' one more time? (Press CTRL-C to abort)", s:prev_char), printf("Say '&%s' one more time!", s:prev_char), 0,  "Error")
  finally
  if s:ugbi_more
    if &syntax == 'saml' || &syntax == 'saml_angriest'
      setlocal syntax=saml_angry
    elseif &syntax == 'saml_angry'
      setlocal syntax=saml_angriest
    endif
    redraw
    call ugbi#SayOneMoreTime()
  else
    normal! H
    let c = 0
    while c <= 80
      execute "normal! \<C-y>"
      execute 'sleep 20ms'
      let c +=1
      redraw
    endwhile
    quit
  endif
  endtry
endfunction

" vim: set shiftwidth=2 tabstop=2 softtabstop=0:

