url = "rcarriga/neotest"

requires = {
  "nvim-lua/plenary.nvim",
  "nvim-treesitter/nvim-treesitter",
  "antoinemadec/FixCursorHold.nvim",

  { "rcarriga/neotest-python" },
  { "rcarriga/neotest-plenary" },
  { "rcarriga/neotest-vim-test" },
}

event = "BufRead"

after = { "vim-test", "neotest-python", "neotest-plenary", "neotest-vim-test" }
