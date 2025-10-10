return {
  "mason-org/mason.nvim",
  cmd = "Mason",
  keys = { { K.p"vm", "<Cmd>Mason<Cr>", desc = "Mason" } },
  event = "VeryLazy",
  opts = {
    ui = {
      width = 0.6,
      height = 0.8,
      backdrop = 100,
    },
  },
}
