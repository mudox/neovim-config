-- stylua: ignore start
local function k(t) return K.p"w" .. t end

return {
  { "<C-w><C-w>", U.window.focus_next_float, desc = "focus next float" },
}
