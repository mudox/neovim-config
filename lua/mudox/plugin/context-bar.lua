local function config()
  require("treesitter-context").setup()
end

return {
  "nvim-treesitter/nvim-treesitter-context",
  event = { "BufRead", "BufNewFile" },
  config = config,
}
