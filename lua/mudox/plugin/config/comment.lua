local xmap = require("mudox.keymap").xmap

xmap("<C-_>", "gc", { remap = true })

local config = {
  toggler = {
    line = "<C-_>", -- Ctrl+/
  },
  mappings = {
    extended = true, -- enable `g>`, `g<` mappings
  },
}

require("Comment").setup(config)
