return {
  "yetone/avante.nvim",
  dependencies = {
    "nvim-treesitter",
    "dressing.nvim",
    "plenary.nvim",
    "nui.nvim",
    -- optional
    "nvim-web-devicons", -- or mini.icons
    "copilot.lua",
    "markview.nvim",
    "img-clip.nvim",
  },
  build = "make",
  cmd = "AvanteAsk",
  opts = {
    -- add any opts here
  },
}
