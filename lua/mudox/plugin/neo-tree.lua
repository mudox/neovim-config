return {
  "nvim-neo-tree/neo-tree.nvim",
  dependencies = {
    "plenary.nvim",
    "mini.nvim",
    "nui.nvim",
  },
  cmd = "Neotree",
  keys = {
    { K.p("on"), "<Cmd>Neotree<Cr>", desc = "[neotree] open" },
  },
}
