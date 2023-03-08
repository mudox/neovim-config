local reach = require("reach")

reach.setup()

local ncmd = require("mudox.keymap").ncmd
ncmd("<M-o>", "ReachOpen buffers")

vim.cmd([[
hi ReachHandleDelete guifg=red
]])
