-- vim: fdm=marker fmr=〈,〉

-- Keymaps 〈

local ncmd = require("mudox.keymap").ncmd
ncmd("]a", "AerialNext")
ncmd("[a", "AerialPrev")

-- Keymaps 〉

-- Config 〈

local i = require("mudox.ui").icons

local float = {
  board = "none",
  max_height = { 20, 0.6 },
}

local kinds = {
  "Module",

  "Interface",

  "Class",
  "Struct",
  "Enum",

  "Constructor",
  "Function",
  "Method",

  -- "Variable",
  -- "Constant",
}

local guides = {
  mid_item = "├─",
  last_item = "└─",
  nested_top = "│ ",
  whitespace = "",
}

require("aerial").setup {
  highlight_on_hover = true,

  min_width = 30,
  float = float,

  close_on_select = true,
  post_jump_cmd = "normal! zzzv",

  icons = i.lsp.kind,

  filter_kind = kinds,

  show_guides = true,
  guides = guides,
}

-- Config 〉
