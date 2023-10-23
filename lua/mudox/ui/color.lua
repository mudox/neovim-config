-- stylua: ignore
local rainbow = {
  red    = { fg = "#E06C75" },
  yellow = { fg = "#E5C07B" },
  blue   = { fg = "#61AFEF" },
  orange = { fg = "#D19A66" },
  green  = { fg = "#98C379" },
  violet = { fg = "#C678DD" },
  cyan   = { fg = "#56B6C2" },
}

-- https://github.com/LunarVim/LunarVim/blob/master/lua/lvim/core/lualine/colors.lua
-- stylua: ignore
local lunar = {
  bg       = "#202328",
  fg       = "#bbc2cf",
  yellow   = "#ECBE7B",
  cyan     = "#008080",
  darkblue = "#081633",
  green    = "#98be65",
  orange   = "#FF8800",
  violet   = "#a9a1e1",
  magenta  = "#c678dd",
  purple   = "#c678dd",
  blue     = "#51afef",
  red      = "#ec5f67",
}

-- stylua: ignore
local sign = {
  yellow   = "#ECBE7B",
  cyan     = "#008080",
  darkblue = "#081633",
  green    = "#00FF00",
  orange   = "#FF8800",
  violet   = "#a9a1e1",
  magenta  = "#c678dd",
  purple   = "#c678dd",
  blue     = "#2176FF",
  red      = "#ec5f67",
  gray     = "#bbc2cf",
}

return {
  rainbow = rainbow,
  sign = sign,
}
