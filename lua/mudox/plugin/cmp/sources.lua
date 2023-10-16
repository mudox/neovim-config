local M = {}
local cmp = require("cmp")
local group = cmp.config.sources

-- you can configure:
-- - keyword_length
-- - priority
-- - max_item_count
local words = {
  name = "look",
  keyword_length = 2,
  max_item_count = 4,
  option = {
    convert_case = true,
    loud = true,
    dict = "/usr/share/dict/words",
  },
}

-- see: https://github.com/hrsh7th/nvim-cmp/wiki/List-of-sources
M.common = cmp.config.sources({
  { name = "nvim_lsp_signature_help" },

  -- LSP & TreeSitter
  { name = "nvim_lsp", max_item_count = 8 },

  -- Snippet
  { name = "luasnip", keyword_length = 2 },

  -- Neovim Lua API
  { name = "nvim_lua", max_item_count = 6 },
  -- Markup languages tags
  { name = "nvim-cmp-ts-tag-close" },

  -- AI engines
  -- { name = "cmp_tabnine", max_item_count = 4 },
  -- TODO: copilot
}, {
  { name = "path", keyword_length = 3 },
  { name = "buffer", keyword_length = 4 },
  { name = "treesitter", keyword_length = 2 },
  { name = "rg", max_item_count = 10 },
}, {
  words,
})

M.search = {
  { name = "buffer", keyword_length = 3 },
  { name = "cmdline_history", keyword_length = 2 },
}

M.cmdline = {
  { name = "path", keyword_length = 2, max_item_count = 4 },
  { name = "cmdline_history", keyword_length = 2, max_item_count = 3 },
  { name = "cmdline", keyword_length = 2 },
}

local c6 = cmp.config.compare
M.sorting = {
  comparators = {
    c6.offset,
    c6.exact,
    c6.score,

    -- refs: https://github.com/lukas-reineke/cmp-under-comparator
    -- > In most languages, especially Python, items that start with one or more underlines
    -- > should be at the end of the completion suggestion
    function(entry1, entry2)
      local _, entry1_under = entry1.completion_item.label:find("^_+")
      local _, entry2_under = entry2.completion_item.label:find("^_+")
      entry1_under = entry1_under or 0
      entry2_under = entry2_under or 0
      if entry1_under > entry2_under then
        return false
      elseif entry1_under < entry2_under then
        return true
      end
    end,

    c6.kind,
    c6.sort_text,
    c6.length,
    c6.order,
  },
}

return M
