return {
  "folke/persistence.nvim",
  event = "BufReadPre",
  opts = {},
  -- stylua: ignore
  -- keys = {
  -- { "<Bs>r", function() require("persistence").load() end,                desc = "[Persistence] Restore" },
  -- { "<Bs>l", function() require("persistence").load({ last = true }) end, desc = "[Persistence] Restore last" },
  -- { "<Bs>d", function() require("persistence").stop() end,                desc = "[Persistence] Don't save" },
  -- },
}
