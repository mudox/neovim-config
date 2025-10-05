local function config()
  require("rainbow-delimiters.setup").setup {
    priority = {
      [""] = 110,
    },
  }
end

return {
  "hiphish/rainbow-delimiters.nvim",
  -- event = { "BufReadPre", "BufNewFile" },
  -- event = "VeryLazy",
  lazy = false,
  config = config,
}
