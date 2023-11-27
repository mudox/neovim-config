local opts = {
  ring = { storage = "sqlite" },
  highlight = { timer = 200 },
}

-- stylua: ignore
local keys = {
  { "<leader>ty", function() require("telescope").extensions.yank_history.yank_history {} end, desc = "[Yanky] History",                    },

  { "y",          "<Plug>(YankyYank)", mode = { "n", "x" },                                    desc = "[Yanky] Yank text"                             },

  { "p",          "<Plug>(YankyPutAfter)", mode = { "n", "x" },                                desc = "[Yanky] Put yanked text after cursor"          },
  { "P",          "<Plug>(YankyPutBefore)", mode = { "n", "x" },                               desc = "[Yanky] Put yanked text before cursor"         },

  { "gp",         "<Plug>(YankyGPutAfter)", mode = { "n", "x" },                               desc = "[Yanky] Put yanked text after selection"       },
  { "gP",         "<Plug>(YankyGPutBefore)", mode = { "n", "x" },                              desc = "[Yanky] Put yanked text before selection"      },

  { "[y",         "<Plug>(YankyCycleForward)",                                                 desc = "[Yanky] Cycle forward through yank history"    },
  { "]y",         "<Plug>(YankyCycleBackward)",                                                desc = "[Yanky] Cycle backward through yank history"   },

  { "]p",         "<Plug>(YankyPutIndentAfterLinewise)",                                       desc = "[Yanky] Put indented after cursor (linewise)"  },
  { "[p",         "<Plug>(YankyPutIndentAfterLinewise)",                                       desc = "[Yanky] Put indented after cursor (linewise)"  },
  { "]P",         "<Plug>(YankyPutIndentBeforeLinewise)",                                      desc = "[Yanky] Put indented before cursor (linewise)" },
  { "[P",         "<Plug>(YankyPutIndentBeforeLinewise)",                                      desc = "[Yanky] Put indented before cursor (linewise)" },

  { ">p",         "<Plug>(YankyPutIndentAfterShiftRight)",                                     desc = "[Yanky] Put and indent right"                  },
  { "<p",         "<Plug>(YankyPutIndentAfterShiftLeft)",                                      desc = "[Yanky] Put and indent left"                   },
  { ">P",         "<Plug>(YankyPutIndentBeforeShiftRight)",                                    desc = "[Yanky] Put before and indent right"           },
  { "<P",         "<Plug>(YankyPutIndentBeforeShiftLeft)",                                     desc = "[Yanky] Put before and indent left"            },

  { "=p",         "<Plug>(YankyPutAfterFilter)",                                               desc = "[Yanky] Put after applying a filter"           },
  { "=P",         "<Plug>(YankyPutBeforeFilter)",                                              desc = "[Yanky] Put before applying a filter"          },
}

return {
  "gbprod/yanky.nvim",
  dependencies = "kkharji/sqlite.lua",
  opts = opts,
  keys = keys,
}
