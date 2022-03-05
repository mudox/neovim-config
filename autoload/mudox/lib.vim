if exists('g:autoloaded_mudox_lib')
  finish
endif
let g:autoloaded_mudox_lib = 1

function! mudox#lib#toggleQuickFix()
  if empty(filter(getwininfo(), 'v:val.quickfix'))
    copen
  else
    cclose
  endif
endfunction

function! mudox#lib#toggleLocList()
  try
    if empty(filter(getwininfo(), 'v:val.loclist'))
      lopen
    else
      lclose
    endif
  catch /E776/
    lua vim.notify(
    \  'Empty location list', 
    \  'warn',
    \  { title = 'ToggleLocList' }
    \)
  endtry
endfunction


function! mudox#lib#wipeoutBuffer()
  try
    bwipeout
  catch /E444/
  catch /E89/
    lua vim.notify(
    \  'There are unsaved changes, can not wipeout buffer', 
    \  'warn',
    \  { title = 'WipeoutBuffer' }
    \)
  endtry
endfunction