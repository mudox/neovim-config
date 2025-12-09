return {
  "saxon1964/neovim-tips",
  cmd = { "NeovimTips", "NeovimTipsRandom", "NeovimTipsEdit", "NeovimTipsAdd", "NeovimTipsPdf" },
  keys = {
    { K.p("vt"), K.c("NeovimTipsPdf"), desc = "neovim tips" },
  },
  dependencies = "MunifTanjim/nui.nvim",
  opts = {
    daily_tip = 0, -- 0 = off, 1 = once per day, 2 = every startup
    bookmark_symbol = " ",
  },
}
