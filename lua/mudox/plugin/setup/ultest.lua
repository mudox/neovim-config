local g = vim.g
g.ultest_max_threads = 6
g.ultest_use_pty = 1

local i = require("mudox.ui").icons
g.ultest_pass_sign = i.heavy_dot
g.ultest_fail_sign = i.heavy_dot
g.ultest_running_sign = i.heavy_dot
g.ultest_not_run_sign = i.heavy_dot

local nplug = require("mudox.keymap").nplug
nplug("]t", "(ultest-next-fail)")
nplug("[t", "(ultest-prev-fail)")
