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

local leader = {
  name = "+leader",

  a = { name = "+aerial" },
  c = { name = "+test" },
  d = { name = "+debug" },
  -- stylua: ignore
  e = {
    name = "+edit",
    q = { "<Cmd>EditQuery<Cr>", "[Neovim] Edit query"  },
    e = { "<Cmd>edit!<Cr>",     "[Neovim] Reload file" },
  },
  l = { name = "+lazy" },
  g = { name = "+git" },
  p = { name = "+profile" },
  -- stylua: ignore
  q = {
    name = "+quit/session",
    q = { "<Cmd>confirm qall<Cr>", "[Neovim] Quit all"          },
    Q = { "<Cmd>qall!<Cr>",        "[Neovim] Quit all forcibly" },
  },
  r = { name = "+run" },
  t = { name = "+telescope" },
  u = { name = "+ui" },
  w = { name = "+window|buffer" },
  -- stylua: ignore
  v = {
    name = "+view",
    l = { "<Cmd>Lazy<Cr>",            "Lazy"                    },

    i = { "<Cmd>Inspect<Cr>",         "[Neovim] Inspect"        },
    o = { "<Cmd>options<Cr>",         "[Neovim] Options"        },
    s = { "<Cmd>scriptnames<Cr>",     "[Neovim] Loaded scripts" },
    t = { "<Cmd>InspectTree<Cr>",     "[Neovim] Inspect tree"   },
    v = { "<Cmd>messages<Cr>",        "[Neovim] Messages"       },
    V = { "<Cmd>verbose version<Cr>", "[Neovim] Inspect tree"   },
  },
  -- stylua: ignore
  x = {
    name = "+trouble",
    L = { "<Cmd>lopen<Cr>", "[Neovim] Location list" },
    Q = { "<Cmd>copen<Cr>", "[Neovim] Quickfix list" },
  },
}

local keymaps = {
  mode = { "n", "v" },

  ["<leader>"] = leader,
  ["<Space>"] = { name = "+common" },

  ["]"] = { name = "+next" },
  ["["] = { name = "+prev" },
  ["\\"] = { name = "+refactoring" },
}

local function config()
  local wk = require("which-key")
  wk.setup(opts)

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
