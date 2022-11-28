if exists("b:current_syntax")
  finish
endif

syntax match sam "."  
syntax match eye "\V..:~~.."
syntax match eye "\V.~:~^. ...^!J!^."
syntax match eye "\V:JJJGB7  :      ~!Y.."
syntax match eye "\V.~B@&&B&!      ..   ^^"
syntax match eye "\VYG&5Y!Y:     .G:   .  :~!"
syntax match eye "\V~?GG?^~     ..  .:77~"
syntax match eye "\V^7J7!^!!^.^~~7J^::"
syntax match eye "\V.. .:.."
syntax match eye "\V.7Y757??!^^~7~."
syntax match eye "\V. ^?!~^Y?.      .JY!  ."
syntax match eye "\V~:^^?J7JY5.  ^. ..  ?5.:.!."
syntax match eye "\V^^~:!JY?P^          ^7  :?7^"
syntax match eye "\V..:JGYY!            "
syntax match eye "\VJJ7Y?!:.:.     .."
syntax match eye "\V.^!~!~:^!JJ~~"

highlight link sam Comment
highlight link eye WarningMsg

highlight link MoreMsg ErrorMsg

" vim: set shiftwidth=2 tabstop=2 softtabstop=0:

