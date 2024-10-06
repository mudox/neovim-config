local once = false
local function toggle()
  if not once then
    require("nvim-highlight-colors").turnOn()
    once = true
  else
    require("nvim-highlight-colors").toggle()
  end
end

return {
  "brenoprata10/nvim-highlight-colors",
  keys = {
    { "coc", toggle, desc = "[Color] Toggle" },
  },
  opts = {
    render = "virtual",
    virtual_symbol_position = "inline",
    virtual_symbol = " ",
    virtual_symbol_suffix = "",
  },
}
