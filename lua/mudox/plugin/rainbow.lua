local function config()
  require("rainbow-delimiters.setup").setup {
    strategy = {
      [""] = "rainbow-delimiters.strategy.local",
    },
    priority = {
      [""] = 110,
    },
    blacklist = { "html" },
  }
end

return {
  "hiphish/rainbow-delimiters.nvim",
  -- event = { "BufReadPre", "BufNewFile" },
  -- event = "VeryLazy",
  lazy = false,
  config = config,
}
