function! s:dump_cmd(cmd)
  try
    redi @"
    silent execute a:cmd
    redi END
    tabnew
    set buftype=nofile
    call append(0, split(@", '\n'))
    delete _
  catch /.*/
    echohl ErrorMsg | echo v:exception | echohl None
  endtry
endfunction

function s:dump_cmd_from_input()
  let cmd = input('command: ')
  if len(cmd) == 0
    return
  endif

  call s:dump_cmd(cmd)
endfunction

command! -nargs=1 -complete=command DumpCmd call <SID>dump_cmd(<q-args>)
nnoremap \cmd <Cmd>call <SID>dump_cmd_from_input()<Cr>