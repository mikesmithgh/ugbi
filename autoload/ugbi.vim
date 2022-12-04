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
      if l:show_count
        let s:msg = printf("'%s':%02d %s", a:key, s:repeat_count, s:msg)
      endif
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

    let l:height = winheight(0)
    execute "silent! 0r ".s:path."/../plugin/sammy.ascii | 0"
    " add whitespace to hide sam
    execute 'silent! call append(line('0'), repeat([""], height)) | 0'
    redraw
    let c = 0
    while c <= l:height
      execute 'silent! normal! ggdd'
      execute 'silent! sleep 20ms'
      let c +=1
      redraw
    endwhile
    normal! gg
    call sammy0#Highlight()
    call sammy1#Highlight()

    let l:popup_msg=printf("Say '%s' again. Say '%s' one more time!%65s%28sUserGettingBored    When the user presses the same key 42 times.%21sJust kidding! :-)", a:key, a:key, '', '', '')
    call popup_create(l:popup_msg, #{
          \ line: 40,
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

function! ugbi#SayOneMoreTime(count)
  let s:ugbi_more = 0
  try 
    let s:ugbi_more = confirm(printf("Say '%s' one more time? (Press CTRL-C to abort)", s:prev_char), printf("Say '&%s' one more time!", s:prev_char), 0,  "Error")
  finally
    if s:ugbi_more && a:count <= 3
      execute 'call sammy'.a:count.'#Highlight()'
      redraw
      call ugbi#SayOneMoreTime(a:count + 1)
    else
      setlocal modifiable
      call clearmatches()
      redraw
      let c = 0
      while c <= winheight(0)
        execute 'silent! normal! ggdd'
        execute 'silent! sleep 20ms'
        let c +=1
        redraw
      endwhile
      tabclose
    endif
  endtry
endfunction

" vim: set shiftwidth=2 tabstop=2 softtabstop=0:

