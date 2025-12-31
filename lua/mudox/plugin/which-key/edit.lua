-- stylua: ignore start
local function k(t) return K.p"e" .. t end

return {
  { k"q", K.c"EditQuery", desc = "treesitter query" },
  { k"e", K.c"edit!",     desc = "reload file"      },
}
