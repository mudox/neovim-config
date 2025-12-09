local function toggle()
  local m = require("blink.indent")
  m.enable(not m.is_enabled { bufnr = 0 }, { bufnr = 0 })
end

return {
  "saghen/blink.indent",
  keys = {
    { K.leader.toggle .. "i", toggle, desc = "indent guidlines" },
  },
  init = function()
    vim.g.indent_guide = false -- disabled initially
  end,
  opts = {
    blocked = {
      filetypes = { include_defaults = true, "help" },
    },
  },
}
