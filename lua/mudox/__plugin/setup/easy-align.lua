vim.g.easy_align_bypass_fold = 1

vim.g.easy_align_delimiters = {
  ["\\"] = {
    pattern = [[\\]],
  },
}

local k = require("mudox.keymap")

k.nplug("ga", "(EasyAlign)")

k.xplug("<Enter>", "(EasyAlign)")
k.xplug("ga", "(EasyAlign)")
