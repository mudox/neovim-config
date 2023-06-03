local M = {}

-- see: https://github.com/hrsh7th/nvim-cmp/wiki/List-of-sources
M.common = {
  -- LSP & TreeSitter
  { name = "nvim_lsp", max_item_count = 8 },
  { name = "nvim_lsp_signature_help" },
  { name = "treesitter" },

  -- tokens from opened buffers
  { name = "buffer", keyword_length = 2 },

  -- file system paths
  { name = "path", keyword_length = 2 },

  -- LuaSnip snippets
  { name = "luasnip", keyword_length = 2 },

  -- TabNine AI completion engine
  { name = "cmp_tabnine", max_item_count = 10 },

  -- source from `rg`
  { name = "rg", max_item_count = 10 },

  -- words
  {
    name = "look",
    keyword_length = 2,
    option = {
      convert_case = true,
      loud = true,
      dict = "/usr/share/dict/words",
    },
  },

  -- lua
  { name = "nvim_lua", max_item_count = 10 }, -- Neovim Lua API

  -- tag closing
  { name = "nvim-cmp-ts-tag-close" },
}

M.search = {
  { name = "buffer", keyword_length = 2 },
  { name = "cmdline_history", keyword_length = 2 },
}

M.cmdline = {
  { name = "path", keyword_length = 2 },
  { name = "cmdline_history", keyword_length = 2 },
  { name = "cmdline", keyword_length = 2 },
}

return M
