-- common options:
--   keyword_length
--   priority
--   max_item_count
-- for list of sourds see
--   https://github.com/hrsh7th/nvim-cmp/wiki/List-of-sources

local cmp = require("cmp")

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

local common = cmp.config.sources({
  -- path
  { name = "path", keyword_length = 3 },
  -- lsp
  { name = "nvim_lsp_signature_help" },
  { name = "nvim_lsp", max_item_count = 8 },
  -- snippet
  { name = "luasnip", keyword_length = 2 },
  -- nvim lua api
  { name = "nvim_lua", max_item_count = 5 },
  -- markup languages tags
  { name = "nvim-cmp-ts-tag-close" },
  -- ai
  -- { name = "cmp_tabnine", max_item_count = 4 },
  -- TODO: tabnine
  -- TODO: copilot
  -- TODO: codium
}, {
  { name = "buffer", keyword_length = 4 },
  { name = "treesitter", keyword_length = 2 },
  { name = "rg", max_item_count = 10 },
}, {
  words,
})

local search = {
  { name = "buffer", keyword_length = 3 },
  { name = "cmdline_history", keyword_length = 2 },
}

local cmdline = {
  { name = "path", keyword_length = 2, max_item_count = 4 },
  { name = "cmdline_history", keyword_length = 2, max_item_count = 3 },
  { name = "cmdline", keyword_length = 2 },
}

local c = cmp.config.compare
local sorting = {
  comparators = {
    c.offset,
    c.exact,
    c.score,

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

    c.kind,
    c.sort_text,
    c.length,
    c.order,
  },
}

return {
  common = common,
  search = search,
  cmdline = cmdline,
  sorting = sorting,
}
