-- see https://github.com/hrsh7th/nvim-cmp/wiki/Example-mappings for examples

local cmp = require("cmp")
local cm = cmp.mapping
local kb = require("mudox.keyboard")
local ctrl_enter = kb.c.cr

local function isc(fn)
  return cm(fn, { "i", "s", "c" })
end

local base = {
  -- select
  ["<C-n>"] = isc(cm.select_next_item { behavior = cmp.SelectBehavior.Select }),
  ["<C-p>"] = isc(cm.select_prev_item { behavior = cmp.SelectBehavior.Select }),

  -- doc scroll
  ["<C-u>"] = isc(cm.scroll_docs(-4)),
  ["<C-d>"] = isc(cm.scroll_docs(4)),

  -- abort
  ["<C-e>"] = isc(cm.abort()),
  [ctrl_enter] = isc(cm.abort()),

  -- confirm
  --   if nothing is selected (including preselections) add a newline as usual.
  --   if something has explicitly been selected by the user, select it.
  -- see: https://github.com/hrsh7th/nvim-cmp/wiki/Example-mappings#safely-select-entries-with-cr
  ["<Cr>"] = cm {
    i = function(fallback)
      if cmp.visible() and cmp.get_active_entry() then
        cmp.confirm { behavior = cmp.ConfirmBehavior.Replace, select = false }
      else
        fallback()
      end
    end,
    s = cm.confirm { select = false },
    c = cm.confirm { behavior = cmp.ConfirmBehavior.Replace, select = false },
  },
}

return {
  base = base,
}
