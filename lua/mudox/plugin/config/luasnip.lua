-- for `friendly-snippets`
require("luasnip.loaders.from_vscode").lazy_load()

-- re-merge my snippets
function _G._mdx_remerge_my_luasnip_snippets()
  loadfile(stdpath.my_snippets .. "/LuaSnip/init.lua")()
  print("Re-merged my luasnip snippets")
end

_mdx_remerge_my_luasnip_snippets()

vim.cmd([[
augroup mdx_auto_merge_luasnip_snippets
autocmd!
autocmd BufWritePost */vim-mysnippets/LuaSnip/*.lua lua _mdx_remerge_my_luasnip_snippets()
augroup END
]])
