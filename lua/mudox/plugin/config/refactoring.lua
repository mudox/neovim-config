local opts = {}

require("refactoring").setup(opts)

local vreq = require("mudox.keymap").vreq

function k(key, cmd)
  vreq(key, "refactoring", ('refactor("%s")'):format(cmd))
end

k(",re", "Extract Function")
k(",rf", "Extract Function To File")
k(",rv", "Extract Variable")
k(",ri", "Inline Variable")
