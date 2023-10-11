local function config()
  local rb = require("rainbow-delimiters")

  local sG = rb.strategy["global"]
  local sL = rb.strategy["local"]
  local sS = function()
    -- local strategy for normal sized files
    -- global strategy for large files
    -- disabled for very large files
    if vim.fn.line("$") > 10000 then
      return nil
    elseif vim.fn.line("$") > 1000 then
      return sG
    else
      return sL
    end
  end

  local whitelist = {
    "lua",
    "json",
  }

  local strategy = {
    [""] = sS,

    html = sL,
    json = sL,

    commonLisp = sL,
    objc = sL,
  }

  vim.g.rainbow_delimiters = {
    whitelist = whitelist,
    strategy = strategy,
  }
end

return {
  "hiphish/rainbow-delimiters.nvim",
  event = { "BufRead", "BufNewFile" },
  config = config,
  cond = false,
}
