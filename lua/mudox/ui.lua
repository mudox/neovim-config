-- vim: fdm=marker fmr=\ 〈,\ 〉

-- Powerline 〈

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
-- stylua: ignore end

powerline.current = powerline.t3

-- 〉

-- Tree 〈

-- stylua: ignore start
local tree = {
  top    = "│ ",
  middle = "├─",
  last   = "└─",
}
-- stylua: ignore end

-- 〉

local border = { "🭽", "▔", "🭾", "▕", "🭿", "▁", "🭼", "▏" }

-- LSP kinds 〈

local kind = {}

-- stylua: ignore start
kind.sf = {
  File          = "􀉆 ",
  Folder        = "􀈖 ",
  Module        = "􀐛 ",
  Package       = "􀒮 ",
  Enum          = "􀂝 ",
  Class         = "􀀉 ",
  Struct        = "􀂹 ",
  Interface     = "􀧫 ",
  Function      = "􀀎 ",
  Method        = "􀂬 ",
  Event         = "􀋦 ",
  Constant      = " ",
  Variable      = " ",
  Value         = " ",
  Text          = " ",
  EnumMember    = "􀷾 ",
  Field         = "􀋡 ",
  Color         = " ",
  Constructor   = " ",
  Keyword       = "􀟕 ",
  Operator      = "􀅺 ",
  Property      = "􀀢 ",
  Reference     = "􀉣 ",
  Snippet       = "􀉈 ",
  TypeParameter = "􀂺 ",
  Unit          = " ",
}

kind.default = {
  File          = " ",
  Folder        = " ",
  Module        = " ",
  Package       = " ",
  Enum          = "🅴 ",
  Class         = "🅲 ",
  Struct        = "🆂 ",
  Interface     = "🅸 ",
  Function      = "ƒ ",
  Method        = " ",
  Event         = " ",
  Constant      = " ",
  Variable      = " ",
  Value         = " ",
  Text          = " ",
  EnumMember    = " ",
  Field         = " ",
  Color         = " ",
  Constructor   = " ",
  Keyword       = " ",
  Operator      = " ",
  Property      = "🄿 ",
  Reference     = " ",
  Snippet       = " ",
  TypeParameter = " ",
  Unit          = " ",
}
-- stylua: ignore end

-- 〉

-- Filetype 〈

-- stylua: ignore start
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
-- stylua: ignore end

-- 〉

-- Folder 〈

-- stylua: ignore start
local folder = {
  default      = " ",
  open         = " ",
  empty        = " ",
  empty_open   = " ",
  symlink      = " ",
  symlink_open = " ",
}
-- stylua: ignore end

-- 〉

-- Icons 〈

-- stylua: ignore start
local icons = {
  error         = " ",
  warn          = " ",
  info          = " ",
  debug         = " ",
  hint          = " ",
  trace         = " ",
  success       = " ",
  light_dot     = "·",
  heavy_dot     = "",
  check         = "✔",
  ballot        = "✘",
  deleted       = " ",
  expanded      = "",
  collapsed     = "",
  folder_closed = " ",
  folder_open   = " ",
  kind          = kind.sf,
  powerline     = powerline,
  tree          = tree,
  folder        = folder,
  filetype      = filetype,
  border        = border,
}
-- stylua: ignore end

-- 〉

-- Colors 〈

local function hi(fg, bg)
  return {
    fg = fg or "NONE",
    bg = bg or "NONE",
  }
end

local function fg(c)
  return {
    fg = c,
    bg = "NONE",
  }
end

local function bg(c)
  return {
    fg = "NONE",
    bg = c,
  }
end

-- stylua: ignore start
local colors = {
  diff = {
    add    = bg("#494d0e"),
    delete = bg("NONE"),
    change = hi("#bbbbee", "#3e5582"),
    text   = fg("white"),
  },
}
-- stylua: ignore end

-- 〉

return {
  icons = icons,
  colors = colors,
}

-- TODO: move `Colorscheme` autocmds here
