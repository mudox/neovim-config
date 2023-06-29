-- vim: fdm=marker fmr=\ 〈,\ 〉

-- Icons Store 〈

-- stylua: ignore start
_ = {
  ActiveLSP              = " ",
  ActiveTS               = " ",
  ArrowLeft              = " ",
  ArrowRight             = " ",
  Bookmarks              = " ",
  BufferClose            = "󰅖 ",
  DapBreakpoint          = " ",
  DapBreakpointCondition = " ",
  DapBreakpointRejected  = " ",
  DapLogPoint            = ".>",
  DapStopped             = "󰁕 ",
  Debugger               = " ",
  DefaultFile            = "󰈙 ",
  Diagnostic             = "󰒡 ",
  DiagnosticError        = " ",
  DiagnosticHint         = "󰌵 ",
  DiagnosticInfo         = "󰋼 ",
  DiagnosticWarn         = " ",
  Ellipsis               = "… ",
  FileNew                = " ",
  FileModified           = " ",
  FileReadOnly           = " ",
  FoldClosed             = " ",
  FoldOpened             = " ",
  FoldSeparator          = "  ",
  FolderClosed           = " ",
  FolderEmpty            = " ",
  FolderOpen             = " ",
  Git                    = "󰊢 ",
  GitAdd                 = " ",
  GitBranch              = " ",
  GitChange              = " ",
  GitConflict            = " ",
  GitDelete              = " ",
  GitIgnored             = "◌ ",
  GitRenamed             = "➜ ",
  GitSign                = "▎ ",
  GitStaged              = "✓ ",
  GitUnstaged            = "✗ ",
  GitUntracked           = "★ ",
  LSPLoaded              = " ",
  LSPLoading1            = " ",
  LSPLoading2            = "󰀚 ",
  LSPLoading3            = " ",
  MacroRecording         = " ",
  Package                = "󰏖 ",
  Paste                  = "󰅌 ",
  Refresh                = " ",
  Search                 = " ",
  Selected               = "❯ ",
  Session                = "󱂬 ",
  Sort                   = "󰒺 ",
  Spellcheck             = "󰓆 ",
  Tab                    = "󰓩 ",
  TabClose               = "󰅙 ",
  Terminal               = " ",
  Window                 = " ",
  WordFile               = "󰈭 ",
  Test                   = "󰙨 ",
  Docs                   = " ",
}
-- stylua: ignore end

-- Icons Store 〉

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
kind.default = {
  Class         = "🅲 ",
  Color         = " ",
  Constant      = " ",
  Constructor   = " ",
  Enum          = "🅴 ",
  EnumMember    = " ",
  Event         = " ",
  Field         = " ",
  File          = " ",
  Folder        = " ",
  Function      = "ƒ ",
  Interface     = "🅸 ",
  Keyword       = " ",
  Method        = " ",
  Module        = " ",
  Operator      = " ",
  Package       = " ",
  Property      = "🄿 ",
  Reference     = " ",
  Snippet       = " ",
  Struct        = "🆂 ",
  Text          = " ",
  TypeParameter = " ",
  Unit          = " ",
  Value         = " ",
  Variable      = " ",
}

kind.sf = {
  Class         = "􀀉 ",
  Color         = " ",
  Constant      = " ",
  Constructor   = " ",
  Enum          = "􀂝 ",
  EnumMember    = "􀷾 ",
  Event         = "􀋦 ",
  Field         = "􀋡 ",
  File          = "􀉆 ",
  Folder        = "􀈖 ",
  Function      = "􀀎 ",
  Interface     = "􀧫 ",
  Keyword       = "􀟕 ",
  Method        = "􀂬 ",
  Module        = "􀐛 ",
  Operator      = "􀅺 ",
  Package       = "􀒮 ",
  Property      = "􀀢 ",
  Reference     = "􀉣 ",
  Snippet       = "􀉈 ",
  Struct        = "􀂹 ",
  Text          = " ",
  TypeParameter = "􀂺 ",
  Unit          = " ",
  Value         = " ",
  Variable      = " ",
}

kind.vscode       = {
  File            = ' ',

  Event           = ' ',

  Function        = '󰊕 ',
  Method          = '󰊕 ',
  Constructor     = '󰊕 ',
  KeywordFunction = '󰊕 ',

  Key             = '󰌋 ',
  Keyword         = '󰌋 ',
  String          = ' ',
  Text            = '󰦨 ',

  Package         = ' ',
  Module          = '󰋺 ',
  Namespace       = '󰕋 ',

  Interface       = ' ',
  Class           = ' ',
  Struct          = ' ',

  Array           = ' ',
  Object          = ' ',

  Null            = '󰟢 ',
  Boolean         = ' ',
  Number          = '# ',
  Operator        = ' ',
  TypeParameter   = ' ',

  Constant        = ' ',
  Variable        = ' ',

  Enum            = ' ',
  EnumMember      = ' ',

  Property        = ' ',
  Field           = ' ',

  Snippet         = " ",
  TabNine         = '󰋙 ',

  Error           = ' ',
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
  config   = "󰣖 ",
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
  -- diagnostics
  -- TODO: put into sub-table `diagnostic`
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

  folder_open   = " ",
  folder_closed = " ",

  kind          = kind.vscode,
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
