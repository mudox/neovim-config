local reach = require("reach")

reach.setup()

local ncmd = require("mudox.keymap").ncmd
ncmd("<M-o>", "ReachOpen buffers")
ncmd("<M-p>", "ReachOpen buffers")
