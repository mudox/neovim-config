return {
  "aaronik/treewalker.nvim",
  cmd = "Treewalker",
  -- stylua: ignore
  keys = {
    { "<Down>",  "<Cmd>Treewalker Down<Cr>zv",  desc = "[Treewalker] Next"   },
    { "<Up>",    "<Cmd>Treewalker Up<Cr>zv",    desc = "[Treewalker] Prev"   },
    { "<Left>",  "<Cmd>Treewalker Left<Cr>zv",  desc = "[Treewalker] Parent" },
    { "<Right>", "<Cmd>Treewalker Right<Cr>zv", desc = "[Treewalker] Child"  },
  },
  opts = {
    highlight = true,
  },
}
