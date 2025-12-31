-- stylua: ignore start
local function k(t) return "<Bs>" .. t end

return {
  { k"v",     K.c"confirm qall",           desc = "exit"                 },
  { k"V",     K.c"qall!",                  desc = "exit!"                },

  { k"r",     K.c"confirm restart",        desc = "restart"              },
  { k"R",     K.c"restart +qall!",         desc = "restart!"             },

  { k"w",     K.c"wincmd c",               desc = "window"               },
  { k"<Tab>", K.c"tabclose",               desc = "tabpage"              },

  { k"f",     U.window.close_all_floats, desc = "all floating windows" },
}
