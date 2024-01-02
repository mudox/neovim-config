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

local blank_up = X.renav.wrap("<Space>", function()
  vim.cmd("put! =repeat(nr2char(10), v:count1)|silent ']+")
end)

local blank_down = X.renav.wrap("<Space>", function()
  vim.cmd("put  =repeat(nr2char(10), v:count1)|silent '[-")
end)

local swap_line_up = X.renav.wrap("e", function()
  vim.cmd("silent! move --" .. vim.v.count1)
  vim.cmd.normal("==")
end)

local swap_line_down = X.renav.wrap("e", function()
  vim.cmd("silent! move +" .. vim.v.count1)
  vim.cmd.normal("==")
end)

local function nav_cmd(target, cmd)
  return X.renav.wrap(target, function()
    vim.cmd("silent! " .. cmd)
  end)
end

local function t(o)
  return { "<Cmd>set " .. o .. "!<Bar>set " .. o .. "?<Cr>", "[Option] " .. o }
end

local function toggle_treesitter_highlighting()
  local function notify(msg)
    vim.notify(msg, vim.log.levels.INFO, { title = "TreeSitter" })
  end

  -- `b:ts_highlight` will be set automatically by `vim.treesitter.[start|stop]`

  if vim.b.ts_highlight then
    vim.treesitter.stop()
    notify("Highlighting is disabled")
  else
    vim.treesitter.start()
    notify("Highlighting is enabled")
  end
end

-- stylua: ignore start

local function c(cmd) return "<Cmd>" .. cmd .. "<Cr>" end

local nvim_view = {
  name      = "+neovim view",

  a         = { c "args",            "Arguments"             },
  B         = { c "buffers!",        "Buffers!"              },
  b         = { c "buffers",         "Buffers"               },
  -- TODO: my own custom info dashboards
  g         = {   "<C-G>",           "File information",     remap = true },
  I         = { c "Inspect!",        "Inspect!"              },
  i         = { c "Inspect",         "Inspect"               },
  j         = { c "jumps",           "Jumps"                 },
  l         = { c "lopen",           "Loclist"               },
  m         = { c "marks",           "Marks"                 },
  o         = { c "options",         "Options"               },
  q         = { c "copen",           "Quickfix"              },
  r         = { c "registers",       "Registers"             },
  s         = { c "scriptnames",     "Loaded scripts"        },
  t         = { c "InspectTree",     "Inspect tree"          },
  u         = { c "undolist",        "Undo list"             },
  v         = { c "messages",        "Messages"              },
  V         = { c "verbose version", "Version"               },

  ["<Tab>"] = { c "tabs",            "Tabpages"              },
  ["="]     = { c "EditQuery",       "TreeSitter playground" },
}

local plugin_view = {
  name = "+plugin view",

  p = { c "Lazy" , "Plugins" },
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

local nvim_toggle = {
  name = "+nvim toggle",

  h = t "hlsearch",
  l = t "list",
  n = t "number",
  r = t "relativenumber",
  s = t "spell",
  w = t "wrap",
  t = { toggle_treesitter_highlighting, "[TreeSitter] highlighting" },
}

local plugin_toggle = {
  name = "+plugin toggle",
}

K.nnop(",")
local plugin = {
  name   = "+leader",

  a      = "+aerial",
  b      = "+buffer",
  c      = "+test",
  d      = "+debug",
  e      = edit,
  f      = "+files",
  g      = "+git",
  l      = "+lazy",
  p      = "+profile",
  r      = "+run",
  t      = "+telescope",
  u      = "+ui",
  v      = plugin_view,
  w      = "+window",
  x      = "+trouble",
}

K.nnop(";")
local nvim = {
  name = "alternative leader",

  v = nvim_view,
}

local next = {
  name = "+next",

  a            = { nav_cmd("a",     "next"),        "Next argument file"     },
  q            = { nav_cmd("q",     "cnext"),       "Next quickfix item"     },
  Q            = { nav_cmd("Q",     "cnfile"),      "Next quickfix file"     },
  l            = { nav_cmd("l",     "lnext"),       "Next loclist item"      },
  L            = { nav_cmd("L",     "lnfile"),      "Next loclist file"      },
  ["<Tab>"]    = { nav_cmd("<Tab>", "tabnext"),     "Next tabpage"           },

  e            = { swap_line_down,                  "Swap line down"         },
  ["<Space>"]  = { blank_down,                      "Add line(s) below"      },
}

local previous = {
  name         = "+previous",

  a            = { nav_cmd("a",     "previous"),    "Previous argument file" },
  q            = { nav_cmd("q",     "cprevious"),   "Previous quickfix item" },
  Q            = { nav_cmd("Q",     "cpfile"),      "Previous quickfix file" },
  l            = { nav_cmd("l",     "lprevious"),   "Previous loclist item"  },
  L            = { nav_cmd("L",     "lpfile"),      "Previous loclist file"  },
  ["<Tab>"]    = { nav_cmd("<Tab>", "tabprevious"), "Previous tabpage"       },

  e            = { swap_line_up,                    "Swap line up"           },
  ["<Space>"]  = { blank_up,                        "Add line(s) above"      },
}

local common = {
  name = "+common",
}

local root = {
  [","]        = plugin,
  [";"]        = nvim,

  ["<Space>"]  = common,
  ["<Tab>"]    = tabpage,
  ["<Bslash>"] = refactoring,
  ["<Bs>"]     = quit,

  ["]"]        = next,
  ["["]        = previous,
  yo           = nvim_toggle,
  co           = plugin_toggle,
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
