-- See https://github.com/folke/which-key.nvim#%EF%B8%8F-configuration
local opts = {
  show_help = true,
  show_keys = true,

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

  operators = {
    gc = "+comments",
  },
}

local function config()
  local wk = require("which-key")
  wk.setup(opts)

  local keymaps = {
    mode = { "n", "v" },

    ["g"] = { name = "+g" },

    ["]"] = { name = "+next" },
    ["["] = { name = "+prev" },

    ["<leader>"] = {
      name = "+leader",

      a = { name = "+aerial" },
      c = { name = "+test" },
      d = { name = "+debug" },
      e = { name = "+edit" },
      l = { name = "+lazy" },
      g = { name = "+git" },
      q = { name = "+quit/session" },
      r = { name = "+run" },
      t = { name = "+telescope" },
      u = { name = "+ui" },
      w = { name = "+windows|buffer" },
      v = {
        name = "+view",
        l = { "<Cmd>Lazy<Cr>", "Lazy" },
        v = { "<Cmd>messages<Cr>", "Neovim messages" },
      },
      x = { name = "+trouble" },

      ["."] = { name = "+toggle" },
    },

    ["<Space>"] = { name = "+common" },
    ["\\"] = { name = "+refactoring" },
  }

  wk.register(keymaps)
end

return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  init = function()
    vim.o.timeout = true
    vim.o.timeoutlen = 300
  end,
  config = config,
}
