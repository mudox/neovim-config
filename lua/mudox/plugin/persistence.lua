return {
  "folke/persistence.nvim",
  event = "BufReadPre",
  opts = { options = { "buffers", "curdir", "tabpages", "winsize", "help", "globals", "skiprtp" } },
    -- stylua: ignore
    keys = {
      { "<leader>qs", function() require("persistence").load() end,                desc = "[Persistence] Restore" },
      { "<leader>ql", function() require("persistence").load({ last = true }) end, desc = "[Persistence] Restore last" },
      { "<leader>qd", function() require("persistence").stop() end,                desc = "[Persistence] Don't save" },
    },
}
