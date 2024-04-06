
-- stylua: ignore
local function r(mod) return require("mudox.plugin.which-key." .. mod) end

local opts = {
  -- See https://github.com/folke/which-key.nvim#%EF%B8%8F-configuration

  show_help = true,
  show_keys = true,

  icons = {
    breadcrumb = require("mudox.ui.icon").chevron.right,
    separator = "",
    group = "",
  },

  layout = {
    -- height = { min = 4, max = 25 }, -- min and max height of the columns
    -- width = { min = 20, max = 50 }, -- min and max width of the columns
    spacing = 6, -- spacing between columns
    align = "center", -- align columns left, center or right
  },

  operators = {
    gc = "comments",
  },
}

-- stylua: ignore start

local function c(cmd) return "<Cmd>" .. cmd .. "<Cr>" end

local close = {
  name = "quit/session",

  v         = { c "confirm qall", "[Neovim] Quit all"          },
  V         = { c "qall!",        "[Neovim] Quit all forcibly" },

  ["<Tab>"] = { c "tabclose",     "[Neovim] Close tabpage"     },
}

local edit = {
  name = "edit",

  q    = { c "EditQuery", "[Neovim] Edit query"  },
  e    = { c "edit!",     "[Neovim] Reload file" },
}

local refactoring = {
  name = "refactoring",

  ["<Space>"] = { c "%s/\\n\\(\\s*\\n\\)\\{2,}/\\r\\r", "Squeeze empty lines" },
}

local tabpage = {
  name = "tabpage",

  n         = { c "tabnew",                "[Neovim] New tabpage"       },
  c         = { c "tabclose",              "[Neovim] Close tabpage"     },
  l         = { c "tablast",               "[Neovim] Last tabpage"      },

  o         = { c "tabnext 1<Bar>tabonly", "[Neovim] Main tabpage only" },
  ["<Tab>"] = { c "tabnext 1",             "[Neovim] Goto main tabpage" },

  ["."]     = { X.tabman.recreate_current, "[Tabman] Recreate current"  },
}

K.nnop(",")
local plugin = {
  name   = "plugin",

  a      = "aerial",
  b      = "buffer",
  c      = "test",
  d      = "debug",
  e      = edit,
  f      = "files",
  g      = "git",
  l      = "lazy",
  p      = "profile",
  r      = "run",
  t      = "telescope",
  u      = "ui",
  v      = r("view").plugin,
  w      = "window",
  x      = "trouble",
}

K.nnop(";")
local nvim = {
  name = "nvim",

  v = r("view").nvim,
  x = { name = "lab" },
}

local common = {
  name = "common",
}

local root = {
  [","]        = plugin,
  [";"]        = nvim,

  ["<Space>"]  = common,
  ["<Tab>"]    = tabpage,
  ["<Bslash>"] = refactoring,
  ["<Bs>"]     = close,

  ["]"]        = r("next_prev").next,
  ["["]        = r("next_prev").prev,
  yo           = r("toggle").nvim,
  co           = r("toggle").plugin,
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
