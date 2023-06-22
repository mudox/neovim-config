if exists('g:autoloaded_mudox_lib')
  finish
endif
let g:autoloaded_mudox_lib = 1

function! mudox#util#toggleQuickFix()
  if empty(filter(getwininfo(), 'v:val.quickfix'))
    copen
  else
    cclose
  endif
endfunction

function! mudox#util#toggleLocList()
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

function! mudox#util#wipeoutBuffer()
  try
    bwipeout
  catch /E444\|E5601/
  catch /E89/
    lua vim.notify(
    \  { 'There are unsaved changes, can not wipeout buffer.', 'Press `ZQ` to discard the window & buffer.' },
    \  'warn',
    \  { title = 'WipeoutBuffer' }
    \)
  endtry
endfunction
