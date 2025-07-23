return {
  "swaits/zellij-nav.nvim",
  event = "VeryLazy",
  -- stylua: ignore
  keys = {
    { "<C-h>", "<Cmd>ZellijNavigateLeftTab<Cr>",  { silent = true, desc = "Navigate left"  }},
    { "<C-j>", "<Cmd>ZellijNavigateDown<Cr>",     { silent = true, desc = "Navigate down"  }},
    { "<C-k>", "<Cmd>ZellijNavigateUp<Cr>",       { silent = true, desc = "Navigate up"    }},
    { "<C-l>", "<Cmd>ZellijNavigateRightTab<Cr>", { silent = true, desc = "Navigate right" }},
  },
  cond = function()
    -- return vim.env.ZELLIJ ~= nil
    return false
  end,
  opts = {},
}
