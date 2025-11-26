return {
  "A7Lavinraj/fyler.nvim",
  cmd = "Fyler",
  -- stylua: ignore
  keys = {
    { K.p"ff", K.c"Fyler",            desc = "[Fyler] Open"       },
    { "<M-o>", K.c"Fyler",            desc = "[Fyler] Open"       },
    { K.p"fF", K.c"Fyler kind=float", desc = "[Fyler] Open float" },
  },
  opts = {
    views = {
      explorer = {
        win_opts = {
          winhighlight = "Normal:MdxFloatFrameNormal,FloatBorder:MdxFloatFrameBorder",
        },
      },
    },
  },
}
