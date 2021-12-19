local opts = {}

require("nnn").setup(opts)

local ncmd  = require("keymap").ncmd

ncmd('<M-p>', 'NnnPicker')
ncmd('<C-M-p>', 'NnnExplorer')
