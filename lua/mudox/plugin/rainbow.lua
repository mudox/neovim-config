local function config()
  require("rainbow-delimiters.setup").setup {
    strategy = {
      [""] = "rainbow-delimiters.strategy.local",
    },
    priority = {
      [""] = 110,
    },
    blacklist = { "html", "markdown" },
  }
end

return {
  "hiphish/rainbow-delimiters.nvim",
  event = { "BufReadPre", "BufNewFile" },
  config = config,
  cond = false, -- ISSUE: invalid api call `range`, introduced around nvim v0.12
}
