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

local function config(_, options)
  local wk = require("which-key")
  wk.setup(options)

  local keymaps = {
    mode = { "n", "v" },

    ["g"] = { name = "+goto" },
    ["gz"] = { name = "+surround" },

    ["]"] = { name = "+next" },
    ["["] = { name = "+prev" },

    ["<leader>"] = {
      name = "+leader",

      ["<tab>"] = { name = "+tabs" },
      b = { name = "+buffer" },
      c = { name = "+code" },
      l = { name = "+lazy" },
      g = { name = "+git" },
      q = { name = "+quit/session" },
      r = { name = "+run" },
      t = { name = "+telescope" },
      u = { name = "+ui" },
      w = { name = "+windows" },
      x = { name = "+diagnostics" },
      yo = {
        name = "+toggle",
        i = { desc = "Ident Guidelines" },
      },
    },

    ["<Space>"] = { name = "+common" },
    ["<M-/>"] = { name = "+panel" },
    ["\\"] = { name = "+refactoring" },
  }

  wk.register(keymaps)
end

return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  opts = opts,
  config = config,
}
