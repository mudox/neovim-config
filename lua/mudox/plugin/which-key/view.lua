local c = K.c

-- stylua: ignore
return {
  { ";v", group = "neovim views" },

  { ";va",     c"args",            desc = "Arguments"             },
  { ";vB",     c"buffers!",        desc = "Buffers!"              },
  { ";vb",     c"buffers",         desc = "Buffers"               },
  { ";vc",     c"ascii",           desc = "ASCII"                 },
  { ";vC",     c"checkhealth",     desc = "Health"                },
  { ";vg",     "8<C-G>",           desc = "Buffer info"           },
  { ";vI",     c"Inspect!",        desc = "Inspect!"              },
  { ";vi",     c"Inspect",         desc = "Inspect"               },
  { ";vj",     c"jumps",           desc = "Jumps"                 },
  { ";vl",     c"lopen",           desc = "Loclist"               },
  { ";vm",     c"marks",           desc = "Marks"                 },
  { ";vo",     c"options",         desc = "Options"               },
  { ";vq",     c"copen",           desc = "Quickfix"              },
  { ";vr",     c"registers",       desc = "Registers"             },
  { ";vs",     c"scriptnames",     desc = "Loaded scripts"        },
  { ";vt",     c"InspectTree",     desc = "Inspect tree"          },
  { ";vu",     c"undolist",        desc = "Undo list"             },
  { ";vv",     c"messages",        desc = "Messages"              },
  { ";vV",     c"verbose version", desc = "Version"               },

  { ";vw",     X.inspect_win,      desc = "Inspect window"        },

  { ";v<Tab>", c"tabs",            desc = "Tabpages"              },
  { ";v=",     c"EditQuery",       desc = "TreeSitter playground" },

  { "<leader>v", group = "plugin views" },

  { "<leader>vz", c"Lazy",     desc = "Lazy"     },
  { "<leader>vw", c"WhichKey", desc = "WhichKey" },
}
