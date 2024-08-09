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

-- stylua: ignore
local border = {
  box =    { "🭽", "▔", "🭾", "▕", "🭿", "▁", "🭼", "▏" },
  corner = { "🭽", " ", "🭾", " ", "🭿", " ", "🭼", " " },
}

-- Border 〉

-- Filetype 〈

-- stylua: ignore
local filetype = {
  markdown   = "",
  git        = " ",
  apple      = " ",
  java       = " ",
  neorg      = "󰏪 ",
  config     = "󰣖 ",
  backup     = " ",
  javascript = " ",
}

-- 〉

-- Folder 〈

-- stylua: ignore
local folder = {
  closed       = "󰉋 ",
  open         = "󰝰 ",
  empty        = "󰉖 ",
  empty_open   = "󰷏 ",

  symlink      = " ",
  symlink_open = " ",
}

-- 〉

-- Diagnostics 〈

-- stylua: ignore
local diagnostics = {
  single = {
    error = "󰉁",
    warn  = "",
    info  = "ℹ",
    debug = "󰊥",
    hint  = "󰙎",
    trace = "𝛵",
  },

  double = {
    error = " ",
    warn  = " ",
    info  = " ",
    debug = " ",
    hint  = "󰏪 ",
    trace = "󰩷 ",
  },

  cod = {
    error = " ",
    warn  = " ",
    info  = " ",
    debug = " ",
    hint  = "󰨄 ",
    trace = "󰛐 ",
  }
}

-- Diagnostics 〉

-- stylua: ignore
local chevron = {
  down  = "󰅀",
  right = "󰅂",
}

-- stylua: ignore
return {
  bar           = "┃",
  short_bar     = "▮",
  border        = border,

  check         = "✔",
  ballot        = "✘",

  chevron       = chevron,

  diagnostics   = diagnostics,
  powerline     = powerline,
  tree          = tree,
  folder        = folder,
  filetype      = filetype,

  kind          = require("mudox.ui.kind"),
}
