-- stylua: ignore
local keys = {
  { "<Tab>g", function() require("mudox.lab.tabman").open("tab Git", "fugitive") end,     desc = "[Fugitive] Open",     },
  { "<Tab>G", function() require("mudox.lab.tabman").recreate("tab Git", "fugitive") end, desc = "[Fugitive] Recreate", },
}

return {
  "tpope/vim-fugitive",
  cmd = { "G", "Git" },
  keys = keys,
}
