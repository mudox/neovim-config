-- stylua: ignore start
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

  check     = "✔",
  cross     = "✘",
  success   = " ",
  
  deleted   = " ",

  expanded  = '',
  collapsed = '',

  lsp = {
    kind = lsp_kind_icons,
  }
}
-- stylua: ignore end

return {
  icons = icons,
}
