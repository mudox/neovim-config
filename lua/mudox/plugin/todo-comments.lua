-- stylua: ignore start
local keys = {
  { "]t", function() require("todo-comments").jump_next() end, desc = "Next todo comment", },
  { "[t", function() require("todo-comments").jump_prev() end, desc = "Previous todo comment", },
  { "<leader>xt", "<Cmd>TodoTrouble<Cr>", desc = "Todo (Trouble)", },
  { "<leader>xT", "<Cmd>TodoTrouble keywords=TODO,FIX,FIXME<Cr>", desc = "Todo/Fix/Fixme (Trouble)", },
  { "<leader>st", "<Cmd>TodoTelescope<Cr>", desc = "Todo", },
}

local keywords = {
  FIX  = { icon = " ", color = "error",   alt = { "FIXME", "BUG", "FIXIT", "ISSUE", } },
  TODO = { icon = " ", color = "info",    alt = { "LATER", "IDEA", } },
  HACK = { icon = " ", color = "warning", alt = { "DANGER", } },
  WARN = { icon = " ", color = "warning", alt = { "WARNING", } },
  PERF = { icon = " ", color = "info",    alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE", } },
  NOTE = { icon = " ", color = "hint",    alt = { "INFO", } }
}
-- stylua: ignore end

local opts = {
  keywords = keywords,
}

return {
  "folke/todo-comments.nvim",
  cmd = { "TodoTrouble", "TodoTelescope", "TodoLocList", "TodoQuickFix" },
  event = { "BufRead", "BufNewFile" },
  keys = keys,
  opts = opts,
}
