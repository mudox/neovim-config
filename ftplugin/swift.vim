" vim: foldmethod=marker

"tab                                                                                   {{{1
"setlocal foldmethod=marker
setlocal tabstop=8
setlocal softtabstop=4
setlocal shiftwidth=4
setlocal smarttab
setlocal expandtab
"}}}1

setlocal synmaxcol=300

"autocmd BufWrite *.swift silent! call FormatSwiftFile()

"function! FormatSwiftFile() abort
  "let nr = line('.')
  "silent! %!swiftformat --quiet
  "execute nr
"endfunction

"nnoremap \af :<C-U><C-U>call FormatSwiftFile()<Cr>
