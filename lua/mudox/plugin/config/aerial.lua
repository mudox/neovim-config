-- vim: fdm=marker fmr=〈,〉

local ncmd = require("mudox.keymap").ncmd
ncmd("<M-/>a", "AerialToggle")
ncmd("<M-/>A", "AerialOpen")
ncmd("]a", "AerialNext")
ncmd("[a", "AerialPrev")

require("aerial").setup({})
