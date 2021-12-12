-- vim:fdm=marker

-- color scheme
-- avoid `:colorsheme` can save ±7ms startuptime
local base16 = require('base16')
base16(base16.themes['gruvbox-dark-hard'], true)

-- diff
vim.cmd [[
hi DiffAdd guibg=None
hi DiffDelete guibg=None
hi DiffChange guibg=None
]]

-- !!!: hack
-- explicity load configs for lazy loading plugins
vim.cmd (([[
  source %s/airline.vim
]]):format(stdpath.lua_plugin_config))

-- prevent built-in plugin loading
vim.g.loaded_netrwPlugin = true

-- temporarily fix: https://github.com/neovim/neovim/issues/11330#issuecomment-900204299
vim.cmd [[ 
autocmd VimEnter * :sleep 20m
autocmd VimEnter * :silent exec "!kill -s SIGWINCH $PPID" 
]]
