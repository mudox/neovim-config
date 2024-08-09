local op = {
  name = "todo item (<C-t>)",
  next = function()
    require("todo-comments").jump_next()
  end,
  prev = function()
    require("todo-comments").jump_prev()
  end,
}

-- stylua: ignore
local keys = {
  { "]<C-t>",     X.dirop.wrap(op, "next"),                       desc = "Next todo comment",        },
  { "[<C-t>",     X.dirop.wrap(op, "prev"),                       desc = "Previous todo comment",    },

  { "<leader>xt", "<Cmd>TodoTrouble<Cr>",                         desc = "[Trouble] Todo",           },
  { "<leader>xT", "<Cmd>TodoTrouble keywords=TODO,FIX,FIXME<Cr>", desc = "[Trouble] Todo|Fix|Fixme", },
  { "<leader>tt", "<Cmd>TodoTelescope<Cr>",                       desc = "Todo",                     },
}

-- stylua: ignore
local keywords = {
  FIX  = { icon = " ", color = "error",   alt = { "FIXME", "BUG", "FIXIT", "ISSUE" } },
  TODO = { icon = "﫠", color = "info",    alt = { "LATER", "IDEA" } },
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
