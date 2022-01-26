local g = vim.g

g.UltiSnipsEditSplit = 'vertical'

local my_snippets_dir = pl.path.join(stdpath.my_pack, 'opt/vim-mysnippets')
g.UltiSnipsSnippetStorageDirectoryForUltiSnipsEdit = pl.path.join(my_snippets_dir, 'UltiSnips')

-- g.UltiSnipsExpandTrigger = '<Tab>'
-- g.UltiSnipsListSnippets = '<C-x>u'
-- g.UltiSnipsJumpForwardTrigger = '<C-j>'
-- g.UltiSnipsJumpBackwardTrigger = '<C-k>'

vim.cmd [[
cabbrev ue UltiSnipsEdit
]]

-- issue: https://github.com/SirVer/ultisnips/issues/1414
-- package entries will not be added to &rtp by nvim automatically
-- while UltiSnips (for now) depends on `&rtp` to discover snippets
vim.opt.runtimepath:append(my_snippets_dir)

-- local vim_snippets_dir = pl.path.join(stdpath.packer_opt, 'vim-snippets')
-- vim.opt.runtimepath:append(vim_snippets_dir)
