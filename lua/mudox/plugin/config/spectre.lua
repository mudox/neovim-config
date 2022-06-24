-- local ncmd = require("mudox.keymap").ncmd
-- ncmd("\\sp", "lua require('spectre').open()")

-- stylua: ignore start
local opts = {
  line_sep_start = "┌──────────────────────────────────────────",
  result_padding = "│  ",
  line_sep       = "└──────────────────────────────────────────",
}
-- stylua: ignore end

require("spectre").setup(opts)
