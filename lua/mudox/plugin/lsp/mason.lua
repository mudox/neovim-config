return {
  "mason-org/mason.nvim",
  cmd = "Mason",
  keys = { { K.p("vm"), "<Cmd>Mason<Cr>", desc = "Mason" } },
  event = "VimEnter", -- before xpress initial term
  opts = {
    ui = {
      width = V.float.width,
      height = V.float.height,
      backdrop = 100,
    },
  },
}
