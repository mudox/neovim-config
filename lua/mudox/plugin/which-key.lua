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

-- stylua: ignore start

local function c(cmd) return "<Cmd>" .. cmd .. "<Cr>" end

local nvim_view = {
  name = "+neovim view",

  a = { c "args",            "Arguments"      },
  B = { c "buffers!",        "Buffers!"       },
  b = { c "buffers",         "Buffers"        },
  I = { c "Inspect!",        "Inspect!"       },
  i = { c "Inspect",         "Inspect"        },
  j = { c "jumps",           "Jumps"          },
  l = { c "lopen",           "Loclist"        },
  m = { c "marks",           "Marks"          },
  o = { c "options",         "Options"        },
  q = { c "copen",           "Quickfix"       },
  r = { c "registers",       "Registers"      },
  s = { c "scriptnames",     "Loaded scripts" },
  t = { c "InspectTree",     "Inspect tree"   },
  u = { c "undolist",        "Undo list"      },
  v = { c "messages",        "Messages"       },
  V = { c "verbose version", "Inspect tree"   },
}

local plugin_view = {
  name = "+plugin view",

  z = { c "Lazy" , "Lazy" },
}

local quit = {
  name = "+quit/session",

  a = { c "confirm qall", "[Neovim] Quit all"          },
  A = { c "qall!",        "[Neovim] Quit all forcibly" },
}

local edit = {
  name = "+edit",

  q    = { c "EditQuery", "[Neovim] Edit query"  },
  e    = { c "edit!",     "[Neovim] Reload file" },
}

local refactoring = {
  name = "+refactoring",

  ["<Space>"] = { c "%s/\\n\\(\\s*\\n\\)\\{2,}/\\r\\r", "Squeeze empty lines" },
}

local tabpage = {
  name = "+tabpage",

  n = { c "tabnew",   "[Neovim] New tabpage"   },
  K = { c "tabclose", "[Neovim] Close tabpage" },
  l = { c "tablast",  "[Neovim] Last tabpage"  },

  ["."]     = { c "tabnext 1<Bar>tabonly", "[Neovim] Main tabpage only" },
  ["<Tab>"] = { c "tabnext 1",             "[Neovim] Goto main tabpage" },
}

local toggle = {
  name = "+toggle",
}

K.nnop(";")
local semicolon = {
  name = "alternative leader",

  v = nvim_view,
  t = toggle,
}

K.nnop(",")
local comma = {
  name   = "+leader",

  a      = "+aerial",
  c      = "+test",
  d      = "+debug",
  e      = edit,
  f      = "+files",
  l      = "+lazy",
  g      = "+git",
  p      = "+profile",
  r      = "+run",
  t      = "+telescope",
  u      = "+ui",
  w      = "+window|buffer",
  v      = plugin_view,
  x      = "+trouble",
}

local root = {
  [","]        = comma,
  [";"]        = semicolon,

  ["<Space>"]  = "+common",
  ["<Tab>"]    = tabpage,
  ["<Bslash>"] = refactoring,
  ["<Bs>"]     = quit,

  ["]"]        = "+next",
  ["["]        = "+prev",
}

-- stylua: ignore end

local function config()
  local wk = require("which-key")
  wk.setup(opts)

  wk.register(root)
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
