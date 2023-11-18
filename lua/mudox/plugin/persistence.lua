return {
  "folke/persistence.nvim",
  event = "BufReadPre",
  opts = { options = { "buffers", "curdir", "tabpages", "winsize", "help", "globals", "skiprtp" } },
    -- stylua: ignore
    keys = {
      { "<Bs>r", function() require("persistence").load() end,                desc = "[Persistence] Restore" },
      { "<Bs>l", function() require("persistence").load({ last = true }) end, desc = "[Persistence] Restore last" },
      { "<Bs>d", function() require("persistence").stop() end,                desc = "[Persistence] Don't save" },
    },
}
