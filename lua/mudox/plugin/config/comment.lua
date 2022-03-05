local ncmd = require("mudox.keymap").ncmd

ncmd("<C-_>", "gcc")

local config = {
  toggler = {
    line = "<C-_>", -- Ctrl+/
  },
  mappings = {
    extended = true, -- enable `g>`, `g<` mappings
  },
}

require("Comment").setup(config)
