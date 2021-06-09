install = [[
Plug 'https://github.com/Chiel92/vim-autoformat.git'
]]

function setup()
  ncmd([[\af]], "Autoformat")

  g.formatdef_luafmt = [["luafmt --stdin -i" . &shiftwidth]]
  g.formatters_lua = {"luafmt"}
end
