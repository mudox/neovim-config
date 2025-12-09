local opts = {
  ring = { storage = "sqlite" },
  highlight = { timer = 200 },
}

-- stylua: ignore
local op = {
  name = "yanky",
  left = function() require("yanky").cycle(1) end,
  right = function() require("yanky").cycle(-1) end,
}

local function paste()
  require("telescope").extensions.yank_history.yank_history()
end

-- stylua: ignore
local keys = {
  { "y",     "<Plug>(YankyYank)",                    desc = "[yanky] yank text",                    mode = { "n", "x" } },

  { K.p"ty", paste,                                  desc = "[yanky] history",                      mode = { "n", "x" } },
  { "[y",    X.arrows.right(op),                     desc = "[yanky] prev entry",                   mode = { "n", "x" } },
  { "]y",    X.arrows.left(op),                      desc = "[yanky] next entry",                   mode = { "n", "x" } },


  { "p",     "<Plug>(YankyPutAfter)",                desc = "[yanky] put after cursor",                                 },
  { "p",     '"_d<Plug>(YankyPutAfter)',             desc = "[yanky] put after cursor",             mode =  "x"         },
  { "P",     "<Plug>(YankyPutBefore)",               desc = "[yanky] put before cursor",            mode = { "n", "x" } },

  { "gp",    "<Plug>(YankyGPutAfter)",               desc = "[yanky] put after selection",          mode = { "n", "x" } },
  { "gP",    "<Plug>(YankyGPutBefore)",              desc = "[yanky] put before selection",         mode = { "n", "x" } },


  { "]p",    "<Plug>(YankyPutIndentAfterLinewise)",  desc = "[yanky] put above",                    mode = { "n", "x" } },
  { "[p",    "<Plug>(YankyPutIndentAfterLinewise)",  desc = "[yanky] put above",                    mode = { "n", "x" } },
  { "]P",    "<Plug>(YankyPutIndentBeforeLinewise)", desc = "[yanky] put below",                    mode = { "n", "x" } },
  { "[P",    "<Plug>(YankyPutIndentBeforeLinewise)", desc = "[yanky] put below",                    mode = { "n", "x" } },
}

return {
  "gbprod/yanky.nvim",
  dependencies = "kkharji/sqlite.lua",
  opts = opts,
  keys = keys,
}
