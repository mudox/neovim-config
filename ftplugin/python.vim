" vim: foldmethod=marker

setlocal foldmethod=marker
setlocal tabstop=2
setlocal softtabstop=2
setlocal shiftwidth=2
setlocal smarttab
setlocal expandtab

" fold
set foldmethod=expr
set foldexpr=nvim_treesitter#foldexpr()
