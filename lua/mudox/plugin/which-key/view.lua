local M = {}

-- stylua: ignore
M[1] = {
  { K.s"v", group = "neovim views" },

  { K.s"v<Cr>",  K.c"!open %:h",                            desc = "finder"                },
  { K.s"v<Tab>", K.c"tabs",                                 desc = "tabpages"              },
  { K.s"v=",     K.c"EditQuery",                            desc = "treesitter playground" },
  { K.s"va",     K.c"args",                                 desc = "arguments"             },
  { K.s"vb",     K.c"buffers!",                             desc = "buffers!"              },
  { K.s"vB",     K.c"buffers",                              desc = "buffers"               },
  { K.s"vc",     K.c"ascii",                                desc = "ascii"                 },
  { K.s"vg",     "8<C-G>",                                  desc = "buffer info"           },
  { K.s"vH",     K.c"checkhealth",                          desc = "health"                },
  { K.s"vI",     K.c"Inspect!",                             desc = "inspect!"              },
  { K.s"vi",     K.c"Inspect",                              desc = "inspect"               },
  { K.s"vj",     K.c"jumps",                                desc = "jumps"                 },
  { K.s"vK",     K.c"nmap <buffer>",                        desc = "local nmaps"           },
  { K.s"vl",     K.c"lopen",                                desc = "loclist"               },
  { K.s"vm",     K.c"marks",                                desc = "marks"                 },
  { K.s"vo",     K.c"options",                              desc = "options"               },
  { K.s"vq",     K.c"copen",                                desc = "quickfix"              },
  { K.s"vr",     K.c"registers",                            desc = "registers"             },
  { K.s"vs",     K.c"scriptnames",                          desc = "loaded scripts"        },
  { K.s"vt",     K.c"InspectTree",                          desc = "inspect tree"          },
  { K.s"vu",     K.c"packadd nvim.undotree <Bar> Undotree", desc = "undo tree"             },
  { K.s"vU",     K.c"undolist",                             desc = "undo list"             },
  { K.s"vv",     K.c"messages",                             desc = "messages"              },
  { K.s"vV",     K.c"verbose version",                      desc = "version"               },
  { K.s"vw",     X.inspect_win,                             desc = "inspect window"        },
}

-- stylua: ignore
M[2] = {
  { K.p"v", group = "plugin views" },

  { K.p"vz", K.c"Lazy",     desc = "[lazy] main window"     },
  { K.p"vk", K.c"WhichKey", desc = "[whichkey] normal" },
}

return M
