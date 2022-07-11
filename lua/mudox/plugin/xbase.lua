url = "xbase-lab/xbase"

run = "make install"

local = true -- `make install` takes long time

requires = {
  "nvim-lua/plenary.nvim",
  "nvim-telescope/telescope.nvim",
  "neovim/nvim-lspconfig",
}
