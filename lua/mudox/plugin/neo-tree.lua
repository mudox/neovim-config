return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  dependencies = {
    "plenary.nvim",
    "nvim-web-devicons",
    "nui.nvim",
  },
  cmd = "Neotree",
  keys = {
    { "<leader>fn", "<Cmd>Neotree<Cr>", desc = "[Neotree] Open" },
  },
}
