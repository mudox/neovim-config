local function opts()
  local symbols = vim.tbl_deep_extend("force", require("mudox.ui").icons.kind, {
    File = "󰈔 ",
    Folder = "",
  })

  return {
    icons = {
      kinds = {
        symbols = symbols,
      },
      ui = {
        bar = {
          separator = "  ",
          extends = "…",
        },
      },
    },
  }
end

return {
  "Bekaboo/dropbar.nvim",
  event = { "BufRead", "BufNewFile" },
  keys = {
    {
      "<M-.>",
      function()
        require("dropbar.api").pick()
      end,
      desc = "Enter Dropbar Pick Mode",
    },
  },
  opts = opts,
}
