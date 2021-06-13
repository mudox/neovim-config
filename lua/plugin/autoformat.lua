install = [[
Plug 'https://github.com/Chiel92/vim-autoformat.git'
]]

function setup()
  ncmd([[\af]], 'Autoformat')

  g.formatters_lua = {'lua-format'}
end
