return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  dependencies = {
    "plenary.nvim",
    "mini.nvim",
    "nui.nvim",
  },
  cmd = "Neotree",
  keys = {
    { K.p"fn", "<Cmd>Neotree<Cr>", desc = "[Neotree] Open" },
  },
}
