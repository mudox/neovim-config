local g = vim.g
local o = vim.o
local k = require('keymap')

g.UltiSnipsEditSplit = 'vertical'
-- symlink from `vim-mysnippets` to here

local dir = os.getenv('HOME') .. '/.local/share/nvim/site/pack/packer/start' ..
              '/vim-mysnippets/Ultisnips'
g.UltiSnipsSnippetStorageDirectoryForUltiSnipsEdit = dir

g.UltiSnipsExpandTrigger = '<tab>'
g.UltiSnipsListSnippets = '<c-tab>'
g.UltiSnipsJumpForwardTrigger = '<c-j>'
g.UltiSnipsJumpBackwardTrigger = '<c-k>'

vim.cmd [[
cabbrev ue UltiSnipsEdit
]]
