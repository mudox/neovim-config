-- stylua: ignore
local function perform(act) require("refactoring").refactor(act) end


-- stylua: ignore
local keys = {
  { "b", function() perform "Extract Block" end,         "Extract Block",         },
  { "B", function() perform "Extract Block To File" end, "Extract Block To File", },
  -- { "i", function() perform "Inline Variable" end,       "Inline Variable",       },

  { "R", function() require("refactoring").select_refactor() end, "Select refactor", },
}
keys = K.lazy_keys(keys, {
  key_prefix = "\\",
  desc_prefix = "Refactoring",
})

return {
  "ThePrimeagen/refactoring.nvim",
  event = { "BufRead", "BufNewFile" },
  opts = true,
  keys = keys,
}
