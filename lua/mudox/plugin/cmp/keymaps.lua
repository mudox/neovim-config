-- see https://github.com/hrsh7th/nvim-cmp/wiki/Example-mappings for examples

local cmp = require("cmp")
local k = cmp.mapping
local function isc(fn)
  return k(fn, { "i", "s", "c" })
end

local base = {
  -- select
  ["<C-n>"] = isc(k.select_next_item { behavior = cmp.SelectBehavior.Select }),
  ["<C-p>"] = isc(k.select_prev_item { behavior = cmp.SelectBehavior.Select }),

  -- doc scroll
  ["<C-u>"] = isc(k.scroll_docs(-4)),
  ["<C-d>"] = isc(k.scroll_docs(4)),

  -- abort
  ["<C-e>"] = isc(k.abort()),

  -- select & confirm unconditionally
  ["<C-Cr>"] = isc(k.confirm { behavior = cmp.ConfirmBehavior.Replace, select = true }),

  -- Enter key
  --   if no selection `abort()` & `fallback()`
  --   else confirm with selection
  -- see: https://github.com/hrsh7th/nvim-cmp/wiki/Example-mappings#safely-select-entries-with-cr
  ["<Cr>"] = isc(function(fallback)
    if cmp.visible() and cmp.get_active_entry() then
      cmp.confirm { behavior = cmp.ConfirmBehavior.Replace, select = false }
    else
      fallback()
    end
  end),
}

return {
  base = base,
}
