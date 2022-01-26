local opts = {}

require("nnn").setup(opts)

local ncmd  = require("keymap").ncmd

ncmd('<M-/>n', 'NnnPicker')
ncmd('<M-/>N', 'NnnExplorer')
