-- vim:fdm=marker

-- color scheme
-- avoid `:colorsheme` can save ±7ms startuptime
local base16 = require("base16")
base16(base16.themes["gruvbox-dark-hard"], true)

-- diff
vim.cmd([[
hi DiffAdd guibg=None
hi DiffDelete guibg=None
hi DiffChange guibg=None
]])

-- prevent built-in plugin loading
vim.g.loaded_netrwPlugin = true

-- HACK: temporarily fix: https://github.com/neovim/neovim/issues/11330#issuecomment-900204299
vim.cmd([[ 
autocmd VimEnter * :sleep 1m
autocmd VimEnter * :silent exec "!kill -s SIGWINCH $PPID" 
]])

-- HACK: disable `filetype.vim` loading
-- track: https://github.com/nathom/filetype.nvim#usage
vim.g.did_load_filetypes = 1
