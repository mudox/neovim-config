-- see https://github.com/folke/todo-comments.nvim#%EF%B8%8F-configuration

-- stylua: ignore start
local opts = {
  keywords = {
    FIX  = { icon = " ", color = "error",   alt = { "FIXME", "BUG", "FIXIT", "ISSUE", } },
    TODO = { icon = " ", color = "info",    alt = { "LATER", "IDEA", } },
    HACK = { icon = "", color = "warning", alt = { "DANGER", } },
    WARN = { icon = " ", color = "warning", alt = { "WARNING", } },
    PERF = { icon = " ", color = "info",    alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE", } },
    NOTE = { icon = " ", color = "hint",    alt = { "INFO", } },
  },
  search = {
    args = {
      "--color=never",
      "--no-heading",
      "--with-filename",
      "--line-number",
      "--column",
      "--glob", '!lua/rocks',
    }
  }
}
-- stylua: ignore end

require("todo-comments").setup(opts)

local ncmd = require("mudox.keymap").ncmd

ncmd(",xt", "TodoTrouble")
ncmd(",tt", "TodoTelescope")
