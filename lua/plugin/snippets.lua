-- vim: fdm=marker

install = [[
Plug 'https://github.com/SirVer/ultisnips.git'
Plug 'https://github.com/honza/vim-snippets'
Plug 'https://gitee.com/mudox/vim-mysnippets.git'
]]


function setup()
  g.UltiSnipsEditSplit           = 'horizontal'
  g.UltiSnipsExpandTrigger       = '<C-Space>'
  g.UltiSnipsJumpForwardTrigger  = '<C-F>'
  g.UltiSnipsJumpBackwardTrigger = '<C-S>'
  g.UltiSnipsListSnippets        = '<C-\\>u'
  g.UltiSnipsNoPythonWarning     = 1
  g.UltiSnipsSnippetDirectories  = { 'ultisnips' }

  vim.cmd [[
  cabbrev ue UltiSnipsEdit
  ]]
end
