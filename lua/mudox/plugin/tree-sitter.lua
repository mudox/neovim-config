url = "nvim-treesitter/nvim-treesitter"

requires = {
  { "nvim-treesitter/nvim-treesitter-textobjects" },
  { "p00f/nvim-ts-rainbow" },
}

run = ":TSUpdate"

event = "BufRead"
