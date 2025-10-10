-- stylua: ignore start

-- helpers
local function r(mod) return require("mudox.plugin.which-key." .. mod) end
local p = K.p
local s = K.s
local sc = K.sc
local c = K.c

local close = {
  { "<Bs>", group = "close" },

  { "<Bs>v",     c"confirm qall",                  desc = "Quit all"                   },
  { "<Bs>V",     c"qall!",                         desc = "Quit all forcibly"          },
  { "<Bs>r",     c"restart",                       desc = "Restart"                    },
  { "<Bs>R",     c"restart!",                      desc = "Restart forcibly"           },

  { "<Bs><Tab>", c"tabclose",                      desc = "Close tabpage"              },
  { "<Bs>w",     c"wincmd c",                      desc = "Close window"               },

  { "<Bs>f",     U.window.close_all_floating_wins, desc = "Close all floating windows" },
}

local edit = {
  { p"eq", c"EditQuery",                                desc = "Edit query",  },
  { p"ee", c"edit!",                                    desc = "Reload file", },
  { p"ev", function() X.layout.secondary:open("#") end, desc = "Edit #",      },
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
  { p"w1", function() X.layout.one_window() end,  desc = "1 window layout"  },
  { p"w2", function() X.layout.two_windows() end, desc = "2 windows layout" },

  { "<C-w><C-w>", U.window.focus_next_floating_win, desc = "Focus next floating windows" },

  -- resize window repeatable
  (function()
    local step = 4
    local prefix = p"wr"

    return {
      { prefix, function() require("which-key").show { keys = prefix, loop = true } end, group = "resize" },

      { prefix .. "w", function() vim.cmd("vertical resize -" .. step) end, group = "- width"   },
      { prefix .. "W", function() vim.cmd("vertical resize +" .. step) end, group = "+ width"   },
      { prefix .. "h", function() vim.cmd("resize -" .. step) end,          group = "- height"  },
      { prefix .. "H", function() vim.cmd("resize +" .. step) end,          group = "+ height"  },
    }
  end)()
}

local primary = {
  { p"b",  group = "buffer"                             },
  { p"c",  group = "test"                               },
  { p"d",  group = "debug"                              },
  { p"e",  group = "edit", edit                         },
  { p"f",  group = "files"                              },
  { p"g",  group = "git"                                },
  { p"i",  group = "inspect"                            },
  { p"k",  group = "kulala"                             },
  { p"p",  group = "profile"                            },
  { p"t",  group = "telescope"                          },
  { p"r",  group = "overseer"                           },
  { p"s",  group = "snacks.picker"                      },
  { p"sf", group = "find"                               },
  { p"w",  group = "window", window,                    },
  { p"x",  group = "trouble"                            },
  { p"z",  group = "visual-multi",  mode = { "n", "x" } },
}

local secondary = {
}

local shortcut = {
  { K.sc"v", c"Lazy", desc = "Plugin manager" },

  { sc"1",      function() X.layout.main:focus() end,     desc = "Focus main window"     },
  { "<C-Cr>",   function() X.layout.main:focus() end,     desc = "Focus main window"     },
  { sc"2",      function() X.layout.secondary:open() end, desc = "Open secondary window" },
  { "<C-S-Cr>", function() X.layout.secondary:open() end, desc = "Open secondary window" },
  { sc"3",      function() X.layout.one_window() end,     desc = "Main window only"      },
}

return {
  { K.leader.primary,   group = "primary",  primary    },
  { K.leader.secondary, group = "seconary", secondary, },
  { K.leader.shortcut,  group = "shortcut", shortcut   },
  { K.leader.toggle,    group = "toggle"               }, -- defined in mudox/plugin/snacks/toggle.lua

  { "<Bslash>", group = "refactoring", refactoring, },
  { "<Bs>",     group = "close",       close,       },
  { "<Tab>",    group = "tabpage",     tabpage,     },

  r"view",
  r"next_prev",
  r"insert",
}
