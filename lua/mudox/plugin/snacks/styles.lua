return {
  default = {
    border = "single",
  },

  select = {
    border = "single",
  },

  minimal = {
    border = "single",
  },

  input = {
    border = "single",
  },

  scratch = {
    width = 120,
    height = 40,
    zindex = 20,
    border = "single",
    wo = {
      winhighlight = require("mudox.ui.color").floating.block.winhl,
    },
    minimal = false,

    bo = {
      buftype = "",
      buflisted = false,
      bufhidden = "hide",
      swapfile = false,
    },
    noautocmd = false,

    title_pos = "center",
    footer_pos = "center",

    backdrop = false,
  },
}
