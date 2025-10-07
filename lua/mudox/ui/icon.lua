-- vim: fml& fdn& fdm=marker fmr=〈,〉

-- Powerline 〈

-- stylua: ignore
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
  table      = "󰝘 ",
  markdown   = " ",
  git        = " ",
  apple      = " ",
  java       = " ",
  neorg      = "󰏪 ",
  config     = "󰣖 ",
  backup     = "󰁯 ",
  javascript = " ",
  key        = "󰯄 ",
  build      = "󰣪 ",
}
filetype = vim.tbl_map(function(i)
  return i:sub(1, -2)
end, filetype)

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

-- Diagnostic 〈

-- stylua: ignore
local diagnostic = {
  sign = "•",

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
  },

  box = {
    error = "🅴",
    warn  = "🆆",
    info  = "🅸",
    debug = " ",
    hint  = "🅷",
    trace = " ",
  }
}

-- Diagnostic 〉

-- stylua: ignore
local chevron = {
  down  = "󰅀",
  right = "󰅂",
}

-- stylua: ignore
return {
  bar           = "┃",
  -- short_bar     = "▮",
  short_bar     = "♦",
  border        = border,

  check         = "✔",
  ballot        = "✘",

  chevron       = chevron,

  diagnostic   = diagnostic,
  powerline     = powerline,
  tree          = tree,
  folder        = folder,
  filetype      = filetype,

  kind          = require("mudox.ui.kind"),
}
