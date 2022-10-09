local xmap = require("mudox.keymap").xmap

xmap("<C-_>", "gc", { remap = true })

local config = {
  toggler = {
    line = "<C-_>", -- Ctrl+/
  },
}

require("Comment").setup(config)
