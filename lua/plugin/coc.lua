url = 'neoclide/coc.nvim'
branch = 'release'

event = 'VimEnter'

config = function()
  vim.cmd(([[source %s/coc.vim]]):format(stdpath.luaplugin))
end
