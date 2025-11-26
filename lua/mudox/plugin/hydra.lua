local function config()
  local m = require("hydra")

  m.setup {}

  m {
    name = "window",
    body = "<C-w>",
    mode = "n",
    hint = false,
    -- stylua: ignore
    heads = {
      { "+", function() vim.cmd.wincmd("+") end },
      { "-", function() vim.cmd.wincmd("-") end },
      { "<", function() vim.cmd.wincmd("<") end },
      { ">", function() vim.cmd.wincmd(">") end },
    },
  }
end

return {
  "nvimtools/hydra.nvim",
  event = "VeryLazy",
  config = config,
  cond = false,
}
