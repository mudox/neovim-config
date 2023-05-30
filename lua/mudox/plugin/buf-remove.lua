-- stylua: ignore start
local keys = {
  { "<C-w>r", function() require("mini.bufremove").delete(0, false) end, desc = "Delete Buffer", },
  { "<C-w><C-r>", function() require("mini.bufremove").delete(0, false) end, desc = "Delete Buffer", },
  { "<C-w>R", function() require("mini.bufremove").delete(0, true) end, desc = "Delete Buffer (Force)", },
}
-- stylua: ignore end

return {
  "echasnovski/mini.bufremove",
  version = false,
  event = { "BufRead, BufNewFile" },
  config = function()
    require("mini.bufremove").setup()
  end,
  keys = keys,
}
