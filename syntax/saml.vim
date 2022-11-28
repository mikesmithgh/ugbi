if exists("b:current_syntax")
  finish
endif

syntax match sam "."  

highlight link sam Comment
highlight link MoreMsg ErrorMsg

" vim: set shiftwidth=2 tabstop=2 softtabstop=0:

