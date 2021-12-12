
url = 'junegunn/vim-easy-align'

function config()
  local vplug = require('keymap').vplug

  vplug('<Cr>', 'LiveEasyAlign')
end
