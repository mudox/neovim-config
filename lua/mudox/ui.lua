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
  File          = " ",
  Folder        = " ",

  Module        = " ",
  Package       = " ",

  Enum          = "🅴 ",
  Class         = "🅲 ",
  Struct        = "🆂 ",
  Interface     = "🅸 ",

  Function      = "",
  Method        = "",
  Event         = "",

  Constant      = "",
  Variable      = "",
  Value         = " ",
  Text          = " ",

  EnumMember    = " ",
  Field         = " ",

  Color         = " ",
  Constructor   = " ",

  Keyword       = " ",
  Operator      = " ",

  Property      = "⚑ ",
  Reference     = " ",

  Snippet       = " ",  -- " "

  TypeParameter = " ",

  Unit          = " ",
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
