return {
  "aaronik/treewalker.nvim",
  cmd = "Treewalker",
  -- stylua: ignore
  keys = {
    { "<Down>",  "<Cmd>Treewalker Down<Cr>zx",  desc = "[Treewalker] Next"   },
    { "<Up>",    "<Cmd>Treewalker Up<Cr>zx",    desc = "[Treewalker] Prev"   },
    { "<Left>",  "<Cmd>Treewalker Left<Cr>zx",  desc = "[Treewalker] Parent" },
    { "<Right>", "<Cmd>Treewalker Right<Cr>zx", desc = "[Treewalker] Child"  },
  },
  opts = {
    highlight = true,
  },
}
