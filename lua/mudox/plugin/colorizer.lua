local function config()
  require("colorizer").setup()
end

return {
  "NvChad/nvim-colorizer.lua",
  event = { "BufRead", "BufNewFile" },
  config = config,
}
