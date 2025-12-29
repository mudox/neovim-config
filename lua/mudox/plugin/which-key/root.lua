-- stylua: ignore start

-- helpers
local function r(mod) return require("mudox.plugin.which-key." .. mod) end
local p = K.p
local s = K.s
local c = K.c

local close = {
  { "<Bs>v",     c"confirm qall",           desc = "exit"                 },
  { "<Bs>V",     c"qall!",                  desc = "exit!"                },

  { "<Bs>r",     c"confirm restart",        desc = "restart"              },
  { "<Bs>R",     c"restart +qall!",         desc = "restart!"             },

  { "<Bs>w",     c"wincmd c",               desc = "window"               },
  { "<Bs><Tab>", c"tabclose",               desc = "tabpage"              },

  { "<Bs>f",     U.window.close_all_floats, desc = "all floating windows" },
}

local edit = {
  { p"eq", c"EditQuery", desc = "edit query",  },
  { p"ee", c"edit!",     desc = "reload file", },
}

local refactoring = {
  { "<Bslash><Space>",  c"%s+\\n\\(\\s*\\n\\)\\{2,}+\\r\\r+e", desc = "squeeze empty lines" },
}

local tabpage = {
  { "<Tab>n",     c"tabnew",                 desc = "new tabpage"           },
  { "<Tab>c",     c"tabclose",               desc = "close tabpage"         },
  { "<Tab>l",     "g<Tab>",                  desc = "last accessed tabpage" },

  { "<Tab>o",     c"tabnext 1<Bar>tabonly",  desc = "main tabpage only"     },
  { "<Tab><Tab>", c"tabnext 1",              desc = "goto main tabpage"     },

  { "<Tab>.",     X.tabman.recreate_current, desc = "[tabman] recreate current"      },
}

local window = {
  { "<C-w><C-w>", U.window.focus_next_floating_win, desc = "focus next floating windows" },
}

local primary = {
  -- { p"a",  group = "..."                             },
  { p"b",  group = "buffer"                             },
  { p"c",  group = "test"                               },
  { p"d",  group = "debug"                              },
  { p"e",  group = "edit", edit                         },
  { p"f",  group = "file"                               },
  { p"fy", group = "copy"                               },
  { p"g",  group = "git", r"git"                        },
  -- { p"h",  group = "..."                             },
  { p"i",  group = "inspect"                            },
  -- { p"j",  group = "..."                             },
  { p"k",  group = "kulala"                             },
  -- { p"l",  group = "..."                             },
  -- { p"m",  group = "..."                             },
  -- { p"n",  group = "..."                             },
  { p"o",  group = "open"                               },
  { p"p",  group = "profile"                            },
  -- { p"q",  group = "..."                             },
  { p"r",  group = "overseer"                           },
  { p"s",  group = "snacks.picker"                      },
  { p"t",  group = "telescope"                          },
  -- { p"u",  group = "..."                             },
  { p"v",  group = "view", r"view"[1]                   },
  { p"w",  group = "window", window,                    },
  { p"x",  group = "trouble"                            },
  -- { p"y",  group = "..."                             },
  { p"z",  group = "visual-multi",  mode = { "n", "x" } },
}

-- stylua: ignore
local secondary = {
  -- { s"a",      group = "..."               },
  -- { s"b",      group = "..."               },
  -- { s"c",      group = "..."               },
  -- { s"d",      group = "..."               },
  {
    { s"e",      group = "edit"                 },
    { s"e[",     group = "in left"              },
    { s"e]",     group = "in right"             },
    { s"e<Tab>", group = "in new tab"           },
  },
  -- { s"f",      group = "..."               },
  -- { s"g",      group = "..."               },
  -- { s"h",      group = "..."               },
  {
    { s"i",      group = "inspect"              },
    { s"iw",     U.inspect.win, desc = 'window' },
  },
  -- { s"j",      group = "..."               },
  -- { s"k",      group = "..."               },
  -- { s"l",      group = "..."               },
  -- { s"m",      group = "..."               },
  -- { s"n",      group = "..."               },
  -- { s"o",      group = "..."               },
  -- { s"p",      group = "..."               },
  -- { s"q",      group = "..."               },
  -- { s"r",      group = "..."               },
  -- { s"s",      group = "..."               },
  -- { s"t",      group = "..."               },
  -- { s"u",      group = "..."               },
  { s"v",      group = "view", r"view"[2]     },
  -- { s"w",      group = "..."               },
  -- { s"x",      group = "..."               },
  -- { s"y",      group = "..."               },
  -- { s"z",      group = "..."               },
}

return {
  { K.leader.primary,   group = "primary",                primary      },
  { K.leader.secondary, group = "seconary",               secondary    },
  { K.leader.shortcut,  group = "shortcut",               r"shortcut"  },
  { K.leader.toggle,    group = "toggle",                              },

  { "<Bslash>",         group = "refactoring",            refactoring, },
  { "<Bs>",             group = "close",                  close,       },
  { "<Tab>",            group = "tabpage",                tabpage,     },


  {
    { "]", group = "next" },
    { "][", group = "start of" },
    { "]]", group = "end of"   },

    { "[", group = "prev" },
    { "[[", group = "start of" },
    { "[]", group = "end of"   },

    r"next_prev",
  },

  { "s", group = "surround" },

  { "<C-p>",          K.p"os",       remap = true, desc = "open files" },
  { "<Space><Space>", K.p"o<Space>", remap = true, desc = "open files" },

  {
    mode = "i",
    { K.leader.ic, group = "insert" },
    r"insert",
  },
}
