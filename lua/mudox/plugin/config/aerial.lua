-- vim: fdm=marker fmr=〈,〉

local ncmd = require("mudox.keymap").ncmd
ncmd("<M-/>a", "AerialToggle")
ncmd("<M-/>A", "AerialOpen")
ncmd("]a", "AerialNext")
ncmd("[a", "AerialPrev")

require("aerial").setup {
  highlight_on_hover = true,

  min_width = 20,

  post_jump_cmd = "normal! zzzv",

  close_on_select = true,

  icons = require("mudox.ui").icons.lsp.kind,

  show_guides = true,
  guides = {
    mid_item = "├─",
    last_item = "└─",
    nested_top = "│ ",
    whitespace = "",
  },
}
