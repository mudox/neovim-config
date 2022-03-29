-- stylua: ignore start
local powerline = {
  t1 = {
    heavy_left  = "",
    heavy_right = "",
    light_left  = "",
    light_right = "",
  },
  t2 = {
    heavy_left  = "",
    heavy_right = "",
    light_left  = "",
    light_right = "",
  }
}

powerline.current = powerline.t1

local tree = {
  top    = "│ ",
  middle = "├─",
  last   = "└─",
}

local lsp_kind_icons = {
  Class         = " ",
  Color         = " ",
  Constant      = " ",
  Constructor   = " ",  -- " "
  Enum          = " ",
  EnumMember    = " ",
  Event         = " ",
  Field         = " ",
  File          = " ",
  Folder        = " ",
  Function      = " ",
  Interface     = " ",
  Keyword       = " ",
  Method        = " ",
  Module        = " ",
  Operator      = " ",
  Package       = " ",
  Property      = "⚑ ",
  Reference     = " ",
  Snippet       = " ",  -- " "
  Struct        = " ",
  Text          = " ",
  TypeParameter = " ",
  Unit          = " ",
  Value         = " ",
  Variable      = " ",  -- " "
}

local icons = {
  error     = " ",
  warn      = " ",
  info      = " ",
  hint      = " ",
  success   = " ",

  light_dot = "·",
  heavy_dot = "",
  check     = "✔",
  cross     = "✘",

  deleted   = " ",

  expanded  = '',
  collapsed = '',

  lsp = {
    kind = lsp_kind_icons,
  },

  powerline = powerline,

  tree = tree,
}
-- stylua: ignore end

return {
  icons = icons,
}
