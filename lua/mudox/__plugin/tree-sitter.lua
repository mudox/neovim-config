url = "nvim-treesitter/nvim-treesitter"

run = ":TSUpdate"

-- TODO: use `for i = 1, #requires` to set `event` and `after`
requires = {
  { "nvim-treesitter/nvim-treesitter-textobjects", event = "BufRead" },
  { "p00f/nvim-ts-rainbow", event = "BufRead" },
  { "nvim-treesitter/playground", cmd = "TSPlaygroundToggle" },
}

after = { "nvim-treesitter-textobjects", "nvim-ts-rainbow", "playground" }

event = "BufRead"
