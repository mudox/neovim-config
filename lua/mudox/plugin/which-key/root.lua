-- stylua: ignore start

-- helpers
local function r(mod) return require("mudox.plugin.which-key." .. mod) end
local p = K.p
local s = K.s

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

local root = {
  { K.leader.primary,       group = "primary",     primary         },
  { K.leader.secondary,     group = "seconary",    secondary       },
  { K.leader.shortcut,      group = "shortcut",    r"shortcut"     },

  { K.leader.toggle,        group = "toggle",                      },
  { K.leader.toggle .. "-", group = "nvim",                        },

  { "<Bslash>",             group = "refactoring", r"refactoring", },
  { "<Bs>",                 group = "close",       r"close",       },
  { "<Tab>",                group = "tabpage",     r"tabpage",     },

  {
    { "]",  group = "next"     },
    { "][", group = "start of" },
    { "]]", group = "end of"   },
    { "[",  group = "prev"     },
    { "[[", group = "start of" },
    { "[]", group = "end of"   },

    r"next_prev",
  },

  { "s", group = "surround / substitute" },
}

-- root key combos
root[#root+1] = {
  remap = true,

  { "<C-p>",          K.p"os",       desc = "[telescope] open files"                   },
  { "<C-S-p>",        K.p"ob",       desc = "[telescope] file browser"                 },
  { "<Space><Space>", K.p"sf",       desc = "[snacks] open files"                      },

  { "<C-S-o>",        K.p"tb",       desc = "[telescope] buffers",                     },

  { "<C-;>",          K.p"tC",       desc = "command history"                          },
  { "<C-S-;>",        V.key.bento,   desc = "bento"                                    },

  { "<M-/>",          K.p"t\\",      desc = "[telescope] / in buffer",                 },
  { "<M-'>",          K.p"om",       desc = "[mini] open %:p",                         },

  { "<C-Cr>",   function() X.layout.left:focus() end,        desc = "focus left"       },
  { "<C-S-CR>", function() X.layout.right:open_or_alt() end, desc = "focus right or #" },
}

-- insert mode keymaps
root[#root+1] = {
  mode = "i",

  { K.leader.ic, group = "insert", r"insert", },
}

return root
