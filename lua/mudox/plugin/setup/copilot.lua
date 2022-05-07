vim.g.copilot_no_tab_map = 1

local iexpr = require("mudox.keymap").iexpr
iexpr("<C-j>", [[copilot#Accept("\<Cr>")]])
