-- for `friendly-snippets`
require("luasnip.loaders.from_vscode").lazy_load()
require("luasnip.loaders.from_snipmate").lazy_load()

-- Mappings
local k = require("mudox.keymap")

-- jump
k.ilua("<M-l>", 'require("luasnip").jump(1)')
k.ilua("<M-h>", 'require("luasnip").jump(-1)')
k.slua("<M-l>", 'require("luasnip").jump(1)')
k.slua("<M-h>", 'require("luasnip").jump(-1)')

-- choice
k.iplug("<M-.>", "<Plug>luasnip-next-choice")
k.splug("<M-.>", "<Plug>luasnip-next-choice")

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
