-- stylua: ignore start
local function k(t) return "<Bslash>" .. t end

return {
  { k"<Space>", K.c[[%s/\v\n(\s*\n){2,}/\r\r/e]], desc = "squeeze empty lines" },
}
