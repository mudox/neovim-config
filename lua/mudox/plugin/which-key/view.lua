local c = K.c

-- stylua: ignore
local function v(k) return K.s("v" .. k) end

-- stylua: ignore
return {
  { K.s"v", group = "neovim views" },

  { v"<Tab>", c"tabs",                                 desc = "Tabpages"              },
  { v"=",     c"EditQuery",                            desc = "TreeSitter playground" },
  { v"a",     c"args",                                 desc = "Arguments"             },
  { v"b",     c"buffers!",                             desc = "Buffers!"              },
  { v"B",     c"buffers",                              desc = "Buffers"               },
  { v"c",     c"ascii",                                desc = "ASCII"                 },
  { v"g",     "8<C-G>",                                desc = "Buffer info"           },
  { v"H",     c"checkhealth",                          desc = "Health"                },
  { v"I",     c"Inspect!",                             desc = "Inspect!"              },
  { v"i",     c"Inspect",                              desc = "Inspect"               },
  { v"j",     c"jumps",                                desc = "Jumps"                 },
  { v"l",     c"lopen",                                desc = "Loclist"               },
  { v"m",     c"marks",                                desc = "Marks"                 },
  { v"o",     c"options",                              desc = "Options"               },
  { v"q",     c"copen",                                desc = "Quickfix"              },
  { v"r",     c"registers",                            desc = "Registers"             },
  { v"s",     c"scriptnames",                          desc = "Loaded scripts"        },
  { v"t",     c"InspectTree",                          desc = "Inspect tree"          },
  { v"u",     c"packadd nvim.undotree <Bar> Undotree", desc = "Undo tree"             },
  { v"U",     c"undolist",                             desc = "Undo list"             },
  { v"v",     c"messages",                             desc = "Messages"              },
  { v"V",     c"verbose version",                      desc = "Version"               },
  { v"w",     X.inspect_win,                           desc = "Inspect window"        },
  { v"x",     c"!open %:h",                            desc = "Finder"                },

  { K.p"v", group = "plugin views" },

  { K.p"vz", c"Lazy",                                  desc = "Lazy"     },
  { K.p"vw", c"WhichKey",                              desc = "WhichKey" },
}
