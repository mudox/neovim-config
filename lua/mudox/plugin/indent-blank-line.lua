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
    exclude = { "help", "alpha", "dashboard", "neo-tree", "Trouble", "lazy" },
  }

  ibl.setup(opts)

  vim.g.rainbow_delimiters = { highlight = highlight }

  local hooks = require("ibl.hooks")
  hooks.register(hooks.type.SCOPE_HIGHLIGHT, hooks.builtin.scope_highlight_from_extmark)
end

return {
  "lukas-reineke/indent-blankline.nvim",
  keys = {
    { "yoi", "<Cmd>IBLToggle<Cr>", desc = "[IBL] Toggle ident guidelines" },
  },
  config = config,
}
