local tabman_id = "Git"
-- stylua: ignore
local keys = {
  { "g", function() X.tabman.open(tabman_id, "tab Git") end,     desc = "[Fugitive] Open",     },
  { "G", function() X.tabman.recreate(tabman_id, "tab Git") end, desc = "[Fugitive] Recreate", },
}

-- stylua: ignore
local cmd = {
  "G", "Git",
  "Gw", "Gwrite",
}

return {
  "tpope/vim-fugitive",
  cmd = cmd,
  keys = keys,
}
