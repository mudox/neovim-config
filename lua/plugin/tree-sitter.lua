url = "nvim-treesitter/nvim-treesitter"

requires = { { "nvim-treesitter/nvim-treesitter-textobjects", event = "VimEnter" } }

event = "VimEnter"

run = ":TSUpdate"
