-- stylua: ignore
local rainbow = {
  blue     = "#61AFEF",
  cyan     = "#56B6C2",
  gray     = "#BBC2CF",
  green    = "#98C379",
  orange   = "#D19A66",
  red      = "#E06C75",
  violet   = "#C678DD",
  yellow   = "#E5C07B",
}

-- https://github.com/LunarVim/LunarVim/blob/master/lua/lvim/core/lualine/colors.lua
-- stylua: ignore
local lunar = {
  bg       = "#202328",
  fg       = "#BBC2CF",
  yellow   = "#ECBE7B",
  cyan     = "#008080",
  darkblue = "#081633",
  green    = "#98BE65",
  orange   = "#FF8800",
  violet   = "#A9A1E1",
  magenta  = "#C678DD",
  purple   = "#C678DD",
  blue     = "#51AFEF",
  red      = "#EC5F67",
}

-- stylua: ignore
local sign = {
  blue     = "#2176FF",
  cyan     = "#008080",
  gray     = "#BBC2CF",
  green    = "#00FF00",
  magenta  = "#C678DD",
  orange   = "#FF8800",
  purple   = "#C678DD",
  red      = "#EC5F67",
  violet   = "#A9A1E1",
  yellow   = "#ECBE7B",
}

return {
  rainbow = rainbow,
  sign = sign,

  -- TODO: uniform floating window colors
  floating = {
    block = {
      title = {
        fg = "",
        bg = "",
      },

      bg1 = "",
      bg2 = "",
      bg3 = "",

      winhl = "NormalFloat:_B,FloatBorder:_BBorder",
    },
  },
}
