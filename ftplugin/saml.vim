" Only do this when not done yet for this buffer (see :help ftplugin)
if exists("b:did_ftplugin")
    finish
endif
let b:did_ftplugin = 1

setlocal syntax=saml  
setlocal buftype=nofile
setlocal bufhidden=wipe
setlocal noswapfile
setlocal shortmess=a
setlocal nomodifiable

" vim: set shiftwidth=2 tabstop=2 softtabstop=0:

