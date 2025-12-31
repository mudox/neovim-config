-- stylua: ignore start

-- helpers
local function r(mod) return require("mudox.plugin.which-key." .. mod) end
local p = K.p
local s = K.s
local c = K.c

local primary = {
  { p"b",  group = "buffer"                  },
  { p"c",  group = "test"                    },
  { p"d",  group = "debug"                   },
  { p"e",  group = "edit",        r"edit"    },
  { p"f",  group = "file"                    },
  { p"fy", group = "copy"                    },
  { p"g",  group = "git",         r"git"     },
  { p"i",  group = "inspect"                 },
  { p"k",  group = "kulala"                  },
  { p"o",  group = "open"                    },
  { p"p",  group = "profile"                 },
  { p"r",  group = "overseer"                },
  { p"s",  group = "snacks.picker"           },
  { p"t",  group = "telescope"               },
  { p"v",  group = "view",        r"view"[1] },
  { p"w",  group = "window",      r"window", },
  { p"x",  group = "trouble"                 },

  { p"z",  group = "visual-multi", mode = { "n", "x" } },
}

local secondary = {
  {
    { s"e",      group = "edit"                 },
    { s"e[",     group = "in left"              },
    { s"e]",     group = "in right"             },
    { s"e<Tab>", group = "in new tab"           },
  },
  {
    { s"i",      group = "inspect"              },
    { s"iw",     U.inspect.win, desc = "window" },
  },
  { s"v",      group = "view", r"view"[2]     },
}

return {
  { K.leader.primary,   group = "primary",      primary         },
  { K.leader.secondary, group = "seconary",     secondary       },
  { K.leader.shortcut,  group = "shortcut",     r"shortcut"     },

  { K.leader.toggle,    group = "toggle",                       },
  { "<Bslash>",         group = "refactoring",  r"refactoring", },
  { "<Bs>",             group = "close",        r"close",       },
  { "<Tab>",            group = "tabpage",      r"tabpage",     },

  {
    { "]",  group = "next"     },
    { "][", group = "start of" },
    { "]]", group = "end of"   },
    { "[",  group = "prev"     },
    { "[[", group = "start of" },
    { "[]", group = "end of"   },

    r"next_prev",
  },

  { "s", group = "surround" },

  { "<C-p>",          K.p"os",       remap = true, desc = "open files"      },
  { "<C-S-p>",        K.p"ob",       remap = true, desc = "file browser"    },
  { "<C-;>",          K.p"tC",       remap = true, desc = "command history" },
  { "<C-S-;>",        K.p"sC",       remap = true, desc = "command history" },
  { "<Space><Space>", K.p"o<Space>", remap = true, desc = "open files"      },

  {
    mode = "i",
    { K.leader.ic, group = "insert", r"insert", },
  },
}
