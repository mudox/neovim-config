local c = K.c

-- stylua: ignore
return {
  { K.s"v", group = "neovim views" },

  { K.s"va",     c"args",            desc = "Arguments"             },
  { K.s"vb",     c"buffers!",        desc = "Buffers!"              },
  { K.s"vB",     c"buffers",         desc = "Buffers"               },
  { K.s"vc",     c"ascii",           desc = "ASCII"                 },
  { K.s"vg",     "8<C-G>",           desc = "Buffer info"           },
  { K.s"vH",     c"checkhealth",     desc = "Health"                },
  { K.s"vI",     c"Inspect!",        desc = "Inspect!"              },
  { K.s"vi",     c"Inspect",         desc = "Inspect"               },
  { K.s"vj",     c"jumps",           desc = "Jumps"                 },
  { K.s"vl",     c"lopen",           desc = "Loclist"               },
  { K.s"vm",     c"marks",           desc = "Marks"                 },
  { K.s"vo",     c"options",         desc = "Options"               },
  { K.s"vq",     c"copen",           desc = "Quickfix"              },
  { K.s"vr",     c"registers",       desc = "Registers"             },
  { K.s"vs",     c"scriptnames",     desc = "Loaded scripts"        },
  { K.s"vt",     c"InspectTree",     desc = "Inspect tree"          },
  { K.s"vu",     c"undolist",        desc = "Undo list"             },
  { K.s"vv",     c"messages",        desc = "Messages"              },
  { K.s"vV",     c"verbose version", desc = "Version"               },

  { K.s"vw",     X.inspect_win,      desc = "Inspect window"        },

  { K.s"v<Tab>", c"tabs",            desc = "Tabpages"              },
  { K.s"v=",     c"EditQuery",       desc = "TreeSitter playground" },

  { K.p"v", group = "plugin views" },

  { K.p"vz", c"Lazy",     desc = "Lazy"     },
  { K.p"vw", c"WhichKey", desc = "WhichKey" },
}
