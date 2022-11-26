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
  setlocal syntax=saml  
  setlocal buftype=nofile
  setlocal bufhidden=wipe
  setlocal noswapfile
  setlocal shortmess=a
  setlocal nomodifiable
endfunction


function! ugbi#ShowSam(key)
  if &ft=='saml'
    return ''
  endif

  let s:prev_char = get(s:, "prev_char", v:null)
  let s:repeat_count = get(s:, "repeat_count", 1) + 1
  let s:msg = get(s:, "ugbi_msg", v:null)

  echohl Normal
  if a:key == s:prev_char
    if s:repeat_count >= 41
      echohl ErrorMsg
      let s:msg = printf("Say '%s' again, I dare you!", a:key)
    elseif s:repeat_count >= 30
      echohl WarningMsg
      let s:msg = printf("Say '%s' again, I dare you!", a:key)
    elseif s:repeat_count >= 20
      echohl Question
      let s:msg = printf("Say '%s' again!", a:key)
    elseif s:repeat_count >= 15
      let s:msg = printf("Say '%s' again", a:key)
    endif
    if s:repeat_count >= 15
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
    set modifiable

    " add whitespace to hide sam
    call append(line("."),   repeat([""], winheight(0) - 1))
    " copy sam into buffer and go back to top
    execute "silent! ".winheight(0)."r" s:path."/../resources/sam.txt | 0"
    redraw

    silent! /\%1c\S
    silent! '/Sam was here'
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

function! ugbi#SayOneMoreTime()
  let s:ugbi_more = 0
  let s:ugbi_more = confirm(printf("Say '%s' one more time? (Press CTRL-C to abort)", s:prev_char), printf("Say '&%s' one more time!", s:prev_char), 0,  "Error")
endfunction

" vim: set shiftwidth=2 tabstop=2 softtabstop=0:

