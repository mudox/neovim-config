local tabman_id = "Git"
-- stylua: ignore
local keys = {
  { "<Tab>g", function() X.tabman.open(tabman_id, "tab Git") end,     desc = "[Fugitive] Open",     },
  { "<Tab>G", function() X.tabman.recreate(tabman_id, "tab Git") end, desc = "[Fugitive] Recreate", },

  { "<Space>g", '<Esc><Esc>:G', desc = "[Fugitive] Command line ...", },
}

-- stylua: ignore
local cmd = {
  "G",  "Git",
  "Gw", "Gwrite",
  "Gr", "Gread",
}

return {
  "tpope/vim-fugitive",
  cmd = cmd,
  keys = keys,
}
