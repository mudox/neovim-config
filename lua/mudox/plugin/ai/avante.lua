return {
  "yetone/avante.nvim",
  dependencies = {
    "nvim-treesitter",
    "dressing.nvim",
    "plenary.nvim",
    "nui.nvim",
    -- optional
    "mini.nvim",
    "copilot.lua",
    "markview.nvim",
    "img-clip.nvim",
  },
  build = "make",
  cmd = "AvanteAsk",
  opts = {},
  cond = false,
}
