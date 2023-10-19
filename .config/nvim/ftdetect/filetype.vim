let s:cpo_save = &cpo
set cpo&vim

au BufRead,BufNewFile *.typoscript setfiletype typoscript
au BufRead,BufNewFile *.tsconfig setfiletype typoscript
au BufRead,BufNewFile ext_typoscript_setup.txt setfiletype typoscript

let &cpo = s:cpo_save
unlet s:cpo_save

" vim: sw=2 ts=2 et
