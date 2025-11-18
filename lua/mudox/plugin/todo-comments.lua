local op = {
  name = "Todo items",
  left = function()
    require("todo-comments").jump_next()
  end,
  right = function()
    require("todo-comments").jump_prev()
  end,
}

-- stylua: ignore
local keys = {
  { "]<C-t>", X.dirop.left(op),  desc = "Next todo comment",     },
  { "[<C-t>", X.dirop.right(op), desc = "Previous todo comment", },

  { K.p"xt", "<Cmd>TodoTrouble<Cr>",                         desc = "Todo",           },
  { K.p"xT", "<Cmd>TodoTrouble keywords=TODO,FIX,FIXME<Cr>", desc = "Todo|Fix|Fixme", },
  { K.p"tt", "<Cmd>TodoTelescope<Cr>",                       desc = "Todo",           },
}

-- stylua: ignore
local keywords = {
  FIX  = { icon = " ", color = "error",   alt = { "FIXME", "BUG", "FIXIT", "ISSUE" } },
  TODO = { icon = " ", color = "info",    alt = { "LATER", "IDEA" } },
  HACK = { icon = "󰂕 ", color = "warning", alt = { "DANGER", "TRACK" } },
  WARN = { icon = " ", color = "warning", alt = { "WARNING" } },
  PERF = { icon = "󰓅 ", color = "info",    alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
  NOTE = { icon = "󰍪 ", color = "hint",    alt = { "INFO" } },
}

local search = {
  args = {
    "--color=never",
    "--no-heading",
    "--with-filename",
    "--line-number",
    "--column",
    "--glob=!lua/rocks/", -- exluce luarocks source files
  },
}

local opts = {
  signs = false,
  keywords = keywords,
  search = search,
}

return {
  "folke/todo-comments.nvim",
  dependencies = "trouble.nvim",
  cmd = { "TodoTrouble", "TodoTelescope", "TodoLocList", "TodoQuickFix" },
  event = { "BufRead", "BufNewFile" },
  keys = keys,
  opts = opts,
}
