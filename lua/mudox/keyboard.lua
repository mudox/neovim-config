-- stylua: ignore
local ctrl = {
  ["/"]  = " ",
  ["cr"] = "␍ ",
  [";"]  = "ǫ ",

  i      = " ",
}

for k, v in pairs(ctrl) do
  ctrl[k] = v:gsub("%s+", "")
end

-- stylua: ignore
local ctrl_shift = {
  ["/"]  = " ",

  ["["]  = "󰜱 ",
  ["]"]  = "󰜴 ",

  h      = "󰶺 ",
  l      = "󰶻 ",
  k      = "󰶼 ",
  j      = "󰶹 ",

  ["cr"] = "⏎ ",

  p      = "󱁖 ",

  [";"]  = "󰜎 ",

  ["."]  = " ",

  o      = " "
}

for k, v in pairs(ctrl_shift) do
  ctrl_shift[k] = v:gsub("%s+", "")
end

return {
  c = ctrl, -- ctrl
  cs = ctrl_shift, -- ctrl+shift
}
