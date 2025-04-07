local function config()
  local ibl = require("ibl")

  local highlight = {
    "RainbowDelimiterRed",
    "RainbowDelimiterYellow",
    "RainbowDelimiterBlue",
    "RainbowDelimiterOrange",
    "RainbowDelimiterGreen",
    "RainbowDelimiterViolet",
    "RainbowDelimiterCyan",
  }

  local opts = {
    enabled = false,
    indent = {
      char = "│",
      highlight = highlight,
    },
    scope = {
      enabled = false,
      highlight = highlight,
    },
    exclude = { filetypes = { "help", "alpha", "dashboard", "neo-tree", "Trouble", "lazy", "NvimTree" } },
  }

  ibl.setup(opts)

  -- local hooks = require("ibl.hooks")
  -- hooks.add(hooks.type.SCOPE_HIGHLIGHT, hooks.builtin.scope_highlight_from_extmark)
end

return {
  "lukas-reineke/indent-blankline.nvim",
  keys = {
    { "coi", "<Cmd>IBLToggle<Cr>", desc = "IndentBlankLine" },
  },
  config = config,
}
