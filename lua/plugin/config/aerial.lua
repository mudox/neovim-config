-- vim: fdm=marker fmr=〈,〉

local ncmd = require('keymap').ncmd
ncmd('<M-/>a', 'AerialToggle')
ncmd('<M-/>A', 'AerialOpen')
ncmd(']a', 'AerialNext')
ncmd('[a', 'AerialPrev')

require("aerial").setup {}
