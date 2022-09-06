-- See https://github.com/folke/which-key.nvim#%EF%B8%8F-configuration
local opts = {
  plugins = {
    spelling = {
      enabled = true, -- enabling this will show WhichKey when pressing z= to select spelling suggestions
      suggestions = 20, -- how many suggestions should be shown in the list?
    },
  },
  icons = {
    breadcrumb = "➠ ", -- symbol used in the command line area that shows your active key combo
    separator = "➠ ", -- symbol used between a key and it's label
    group = "+", -- symbol prepended to a group
  },
  layout = {
    -- height = { min = 4, max = 25 }, -- min and max height of the columns
    -- width = { min = 20, max = 50 }, -- min and max width of the columns
    spacing = 6, -- spacing between columns
    align = "center", -- align columns left, center or right
  },
}

require("which-key").setup(opts)
