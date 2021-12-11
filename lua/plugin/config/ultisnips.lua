local g = vim.g

g.UltiSnipsEditSplit = 'vertical'

-- g.UltiSnipsSnippetDirectories = ['UltiSnips']

local dir = pl.path.join(stdpath.packer_start, 'vim-mysnippets/Ultisnips')
g.UltiSnipsSnippetStorageDirectoryForUltiSnipsEdit = dir

g.UltiSnipsExpandTrigger = '<Tab>'
g.UltiSnipsListSnippets = '<C-x>u'
g.UltiSnipsJumpForwardTrigger = '<C-j>'
g.UltiSnipsJumpBackwardTrigger = '<C-k>'

vim.cmd [[
cabbrev ue UltiSnipsEdit
]]

-- issue: https://github.com/SirVer/ultisnips/issues/1414
-- package entries will not be added to &rtp by nvim automatically
-- while UltiSnips (for now) depends on `&rtp` to discover snippets
local dir1 = pl.path.join(stdpath.packer_start, 'vim-mysnippets')
vim.o.runtimepath = vim.o.runtimepath .. ',' .. dir1
local dir2 = pl.path.join(stdpath.packer_start, 'vim-snippets')
vim.o.runtimepath = vim.o.runtimepath .. ',' .. dir2
