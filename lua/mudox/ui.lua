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
  },
  t3 = {
    heavy_left  = "",
    heavy_right = "",
    light_left  = "",
    light_right = "",
  },

}

powerline.current = powerline.t3

local tree = {
  top    = "│ ",
  middle = "├─",
  last   = "└─",
}

local lsp_kind_icons = {
  Class         = " ",
  Color         = " ",
  Constant      = " ",
  Constructor   = " ",
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
  Variable      = " ",
}

local filetype = {
  markdown = " ",
  git      = " ",
  apple    = " ",
  java     = " ",
  neorg    = " ",
  config   = " ",
  compiled = " ",
  backup   = " ",
  script   = " ",
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
  ballot    = "✘",

  deleted   = " ",

  expanded  = '',
  collapsed = '',

  lsp = {
    kind = lsp_kind_icons,
  },

  powerline = powerline,
  tree = tree,
  filetype = filetype,
}
-- stylua: ignore end

return {
  icons = icons,
}
