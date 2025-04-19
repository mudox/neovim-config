-- stylua: ignore start

-- helpers
local function r(mod) return require("mudox.plugin.which-key." .. mod) end
local function c(cmd) return "<Cmd>" .. cmd .. "<Cr>" end

local close = {
  { "<Bs>", group = "close" },

  { "<Bs>v",     c"confirm qall",      desc = "Quit all"                   },
  { "<Bs>V",     c"qall!",             desc = "Quit all forcibly"          },

  { "<Bs><Tab>", c"tabclose",          desc = "Close tabpage"              },
  { "<Bs>w",     c"wincmd c",          desc = "Close window"               },

  { "<Bs>f",     U.window.close_all_floating_wins, desc = "Close all floating windows" },
}

local edit = {
  { "<leader>eq", c"EditQuery",                                desc = "Edit query",  },
  { "<leader>ee", c"edit!",                                    desc = "Reload file", },
  { "<leader>ev", function() X.layout.secondary:open("#") end, desc = "Edit #",      },
}

local refactoring = {
  { "<Bslash>", group = "refactoring" },

  { "<Bslash><Space>",  c"%s+\\n\\(\\s*\\n\\)\\{2,}+\\r\\r+e", desc = "Squeeze empty lines" },
}

local tabpage = {
  { "<Tab>", group = "tabpage" },

  { "<Tab>n",     c"tabnew",                 desc = "New tabpage"           },
  { "<Tab>c",     c"tabclose",               desc = "Close tabpage"         },
  { "<Tab>l",     "g<Tab>",                  desc = "Last accessed tabpage" },

  { "<Tab>o",     c"tabnext 1<Bar>tabonly",  desc = "Main tabpage only"     },
  { "<Tab><Tab>", c"tabnext 1",              desc = "Goto main tabpage"     },

  { "<Tab>.",     X.tabman.recreate_current, desc = "[Tabman] Recreate current"      },
}

local window = {
  { "<leader>w1", function() X.layout.one_window() end,  desc = "1 window layout"  },
  { "<leader>w2", function() X.layout.two_windows() end, desc = "2 windows layout" },

  { "<C-w><C-w>", U.window.focus_next_floating_win, desc = "Close all floating windows" },
}

K.nnop(",")
local prefix1 = {
  { "<leader>",   group = "main",          mode = { "n", "x" } },

  { "<leader>b",  group = "buffer"                             },
  { "<leader>c",  group = "test"                               },
  { "<leader>d",  group = "debug"                              },
  { "<leader>e",  group = "edit", edit                         },
  { "<leader>f",  group = "files"                              },
  { "<leader>g",  group = "git"                                },
  { "<leader>i",  group = "inspect"                            },
  { "<leader>k",  group = "kulala"                             },
  { "<leader>p",  group = "profile"                            },
  { "<leader>r",  group = "run"                                },
  { "<leader>t",  group = "telescope"                          },
  { "<leader>s",  group = "snacks.picker"                      },
  { "<leader>sf", group = "find"                               },
  { "<leader>w",  group = "window", window,                    },
  { "<leader>x",  group = "trouble"                            },
  { "<leader>z",  group = "visual-multi",  mode = { "n", "x" } },
}

K.nnop(";")
local prefix2 = {
  { ";", group = "nvim" },

  -- layout
  { ";1",       function() X.layout.main:focus() end,     desc = "Focus main window"     },
  { "<C-Cr>",   function() X.layout.main:focus() end,     desc = "Focus main window"     },
  { ";2",       function() X.layout.secondary:open() end, desc = "Open secondary window" },
  { "<C-S-Cr>", function() X.layout.secondary:open() end, desc = "Open secondary window" },
  { ";3",       function() X.layout.one_window() end,     desc = "Main window only"      },
}

local resize_window = (function()
  local step = 4
  local prefix = "<C-w>r"

  return {
    { "<C-w>r", function() require("which-key").show { keys = prefix, loop = true } end, desc = "Resize" },

    { prefix, group = "resize" },
    { prefix .. "h", function() vim.cmd("resize +" .. step) end,          group = "Increase width"  },
    { prefix .. "H", function() vim.cmd("resize -" .. step) end,          group = "Decrease width"  },
    { prefix .. "w", function() vim.cmd("vertical resize +" .. step) end, group = "Increase height" },
    { prefix .. "W", function() vim.cmd("vertical resize -" .. step) end, group = "Decrease height" },
  }
end)()

return {
  { "<Space>",  group = "common",                   },
  { "<leader>", group = "main",        prefix1,     },
  { ";",        group = "secondary",   prefix2,     },
  { "<Bslash>", group = "refactoring", refactoring, },
  { "<Bs>",     group = "close",       close,       },
  { "<Tab>",    group = "tabpage",     tabpage,     },

  r"view",
  r"next_prev",
  r"insert",

  resize_window,

  { C.key.toggle, group = "toggle"      }, -- defined in mudox/plugin/snacks/toggle.lua
}
