-- vim: fml& fdn& fdm=marker fmr=〈,〉

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

powerline.current = powerline.t1

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

-- Border 〈

-- stylua: ignore start
local border = {
  box =    { "🭽", "▔", "🭾", "▕", "🭿", "▁", "🭼", "▏" },
  corner = { "🭽", " ", "🭾", " ", "🭿", " ", "🭼", " " },
}
-- stylua: ignore end

-- Border 〉

-- Filetype 〈

-- stylua: ignore
local filetype = {
  markdown   = " ",
  git        = " ",
  apple      = " ",
  java       = " ",
  neorg      = "󰏪 ",
  config     = "󰣖 ",
  compiled   = " ",
  backup     = " ",
  javascript = " ",
}

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

-- Diagnostics 〈

-- stylua: ignore
local diagnostics = {
  error         = "󰉁",
  warn          = "",
  info          = "ℹ",
  debug         = "󰊥",
  hint          = "󰙎",

  -- error         = " ",
  -- warn          = " ",
  -- info          = " ",
  -- debug         = " ",
  -- hint          = " ",
  -- trace         = " ",
  -- success       = " ",
}

-- Diagnostics 〉

-- stylua: ignore start
return {
  light_dot     = "·",
  heavy_dot     = "",

  check         = "✔",
  ballot        = "✘",

  deleted       = " ",

  expanded      = "",
  collapsed     = "",

  folder_open   = " ",
  folder_closed = " ",

  diagnostics   = diagnostics,
  kind          = require("mudox.ui.kind"),
  powerline     = powerline,
  tree          = tree,
  folder        = folder,
  filetype      = filetype,

  border        = border,
}
-- stylua: ignore end
