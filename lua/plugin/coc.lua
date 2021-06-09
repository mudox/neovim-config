install = [[
Plug 'https://github.com/neoclide/coc.nvim.git', {'branch': 'release'}
]]

function setup()
  vim.cmd(([[source %s/coc.vim]]):format(stdpath.luaplugin))
end
