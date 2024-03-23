local opts = {
  ring = { storage = "sqlite" },
  highlight = { timer = 200 },
}

-- stylua: ignore
local op = {
  name = "yanky",
  next = function() require("yanky").cycle(-1) end,
  prev = function() require("yanky").cycle(1) end,
}

-- stylua: ignore
local keys = {
  { "<leader>ty", function() require("telescope").extensions.yank_history.yank_history {} end, desc = "[Yanky] History",                      },

  { "y",          "<Plug>(YankyYank)", mode = { "n", "x" },                                    desc = "[Yanky] Yank text"                     },

  { "p",          "<Plug>(YankyPutAfter)", mode = { "n", "x" },                                desc = "[Yanky] Put yanked text after cursor"  },
  { "P",          "<Plug>(YankyPutBefore)", mode = { "n", "x" },                               desc = "[Yanky] Put yanked text before cursor" },

  { "[y",         X.dirop.wrap(op, 'prev'),                                                    desc = "[Yanky] Next entry"                    },
  { "]y",         X.dirop.wrap(op, 'next'),                                                    desc = "[Yanky] Previous entry"                },

  { "gp",         "<Plug>(YankyGPutAfter)", mode = { "n", "x" },                               desc = "[Yanky] Put after selection"           },
  { "gP",         "<Plug>(YankyGPutBefore)", mode = { "n", "x" },                              desc = "[Yanky] Put before selection"          },


  { "]p",         "<Plug>(YankyPutIndentAfterLinewise)",                                       desc = "[Yanky] Put after (linewise)"          },
  { "[p",         "<Plug>(YankyPutIndentAfterLinewise)",                                       desc = "[Yanky] Put after (linewise)"          },
  { "]P",         "<Plug>(YankyPutIndentBeforeLinewise)",                                      desc = "[Yanky] Put before (linewise)"         },
  { "[P",         "<Plug>(YankyPutIndentBeforeLinewise)",                                      desc = "[Yanky] Put before (linewise)"         },

  { ">p",         "<Plug>(YankyPutIndentAfterShiftRight)",                                     desc = "[Yanky] Put and indent right"          },
  { "<p",         "<Plug>(YankyPutIndentAfterShiftLeft)",                                      desc = "[Yanky] Put and indent left"           },
  { ">P",         "<Plug>(YankyPutIndentBeforeShiftRight)",                                    desc = "[Yanky] Put before and indent right"   },
  { "<P",         "<Plug>(YankyPutIndentBeforeShiftLeft)",                                     desc = "[Yanky] Put before and indent left"    },

  { "=p",         "<Plug>(YankyPutAfterFilter)",                                               desc = "[Yanky] Put after applying a filter"   },
  { "=P",         "<Plug>(YankyPutBeforeFilter)",                                              desc = "[Yanky] Put before applying a filter"  },
}

return {
  "gbprod/yanky.nvim",
  dependencies = "kkharji/sqlite.lua",
  opts = opts,
  keys = keys,
}
