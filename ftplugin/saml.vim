" Only do this when not done yet for this buffer (see :help ftplugin)
if exists("b:did_ftplugin")
    finish
endif
let b:did_ftplugin = 1

call ugbi#SamlFileType()

