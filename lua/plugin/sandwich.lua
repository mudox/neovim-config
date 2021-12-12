
url = 'machakann/vim-sandwich'

event = 'VimEnter'

function config()
  local k = require('keymap')

  -- use `cl` instead
  k.nnop('s')
  k.xnop('s')
end
