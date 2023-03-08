local keys = {
  {
    "]t",
    function()
      require("todo-comments").jump_next()
    end,
    desc = "Next todo comment",
  },
  {
    "[t",
    function()
      require("todo-comments").jump_prev()
    end,
    desc = "Previous todo comment",
  },
  {
    "<leader>xt",
    "<Cmd>TodoTrouble<Cr>",
    desc = "Todo (Trouble)",
  },
  {
    "<leader>xT",
    "<Cmd>TodoTrouble keywords=TODO,FIX,FIXME<Cr>",
    desc = "Todo/Fix/Fixme (Trouble)",
  },
  {
    "<leader>st",
    "<Cmd>TodoTelescope<Cr>",
    desc = "Todo",
  },
}

return {
  "folke/todo-comments.nvim",
  cmd = { "TodoTrouble", "TodoTelescope" },
  event = { "BufReadPost", "BufNewFile" },
  config = true,
  keys = keys,
}
