local tabman_id = "Git"
-- stylua: ignore
local keys = {
  { "<Tab>g", function() X.tabman.open(tabman_id, "tab Git") end,     desc = "[Fugitive] Open",     },
  { "<Tab>G", function() X.tabman.recreate(tabman_id, "tab Git") end, desc = "[Fugitive] Recreate", },
}

return {
  "tpope/vim-fugitive",
  cmd = { "G", "Git" },
  keys = keys,
}
