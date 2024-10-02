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

local function paste()
  require("telescope").extensions.yank_history.yank_history()
end

-- stylua: ignore
local keys = {
  { "<leader>ty", paste,                                    desc =  "[Yanky] History",                       mode =  { "n", "x" } },

  { "y",          "<Plug>(YankyYank)",                      desc =  "[Yanky] Yank text",                     mode =  { "n", "x" } },

  { "p",          "<Plug>(YankyPutAfter)",                  desc =  "[Yanky] Put after cursor",              mode =  { "n", "x" } },
  { "P",          "<Plug>(YankyPutBefore)",                 desc =  "[Yanky] Put before cursor",             mode =  { "n", "x" } },

  { "[y",         X.dirop.wrap(op, 'prev'),                 desc =  "[Yanky] Next entry"                                          },
  { "]y",         X.dirop.wrap(op, 'next'),                 desc =  "[Yanky] Previous entry"                                      },

  { "gp",         "<Plug>(YankyGPutAfter)",                 desc =  "[Yanky] Put after selection",           mode =  { "n", "x" } },
  { "gP",         "<Plug>(YankyGPutBefore)",                desc =  "[Yanky] Put before selection",          mode =  { "n", "x" } },


  { "]p",         "<Plug>(YankyPutIndentAfterLinewise)",    desc =  "[Yanky] Put after (linewise)"                                },
  { "[p",         "<Plug>(YankyPutIndentAfterLinewise)",    desc =  "[Yanky] Put after (linewise)"                                },
  { "]P",         "<Plug>(YankyPutIndentBeforeLinewise)",   desc =  "[Yanky] Put before (linewise)"                               },
  { "[P",         "<Plug>(YankyPutIndentBeforeLinewise)",   desc =  "[Yanky] Put before (linewise)"                               },

  { ">p",         "<Plug>(YankyPutIndentAfterShiftRight)",  desc =  "[Yanky] Put and indent right"                                },
  { "<p",         "<Plug>(YankyPutIndentAfterShiftLeft)",   desc =  "[Yanky] Put and indent left"                                 },
  { ">P",         "<Plug>(YankyPutIndentBeforeShiftRight)", desc =  "[Yanky] Put before and indent right"                         },
  { "<P",         "<Plug>(YankyPutIndentBeforeShiftLeft)",  desc =  "[Yanky] Put before and indent left"                          },

  { "=p",         "<Plug>(YankyPutAfterFilter)",            desc =  "[Yanky] Put after applying a filter"                         },
  { "=P",         "<Plug>(YankyPutBeforeFilter)",           desc =  "[Yanky] Put before applying a filter"                        },
}

return {
  "gbprod/yanky.nvim",
  dependencies = "kkharji/sqlite.lua",
  opts = opts,
  keys = keys,
}
