-- stylua: ignore start
local function k(t) return "<Tab>" .. t end

return {
  { k"n",     K.c"tabnew",                 desc = "new"           },
  { k"l",     "g<Tab>",                    desc = "last accessed" },

  { k"o",     K.c"tabnext 1<Bar>tabonly",  desc = "main only"     },
  { k"<Tab>", K.c"tabnext 1",              desc = "goto main"     },

  { k".",     X.tabman.recreate_current,   desc = "[tabman] recreate current" },
}
