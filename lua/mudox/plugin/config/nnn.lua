local opts = {
  window_nav = "<C-l>",
}

require("nnn").setup(opts)

local ncmd = require("mudox.keymap").ncmd

ncmd("<M-/>n", "NnnPicker")
ncmd("<M-/>N", "NnnExplorer")
ncmd("<M-n>", "NnnExplorer")
