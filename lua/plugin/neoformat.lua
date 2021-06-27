url = 'sbdchd/neoformat'

keys = {[[\af]]}

function config()
  local ncmd = require('keymap').ncmd

  ncmd([[\af]], 'Neoformat')
end
