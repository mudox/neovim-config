local M = {}

M.default = {
  border = "single",
}

M.select = {
  border = "single",
}

M.minimal = {
  border = "single",
}

M.input = {
  border = "single",
}

M.scratch = {
  width = 120,
  height = 40,
  zindex = 20,

  border = "single",
  title_pos = "left",
  footer_pos = "right",

  backdrop = false,

  minimal = true,
  wo = {
    winhighlight = require("mudox.ui.color").floating.block.winhl,
    foldenable = false,
  },
  bo = {
    bufhidden = "hide",
    buflisted = false,
    buftype = "",
    swapfile = false,
  },
  noautocmd = false,
}

return M
