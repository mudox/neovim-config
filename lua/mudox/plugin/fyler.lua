return {
  "A7Lavinraj/fyler.nvim",
  cmd = "Fyler",
  -- stylua: ignore
  keys = {
    { K.p"of", K.c"Fyler",            desc = "[fyler] open"       },
    { K.p"oF", K.c"Fyler kind=float", desc = "[fyler] open float" },
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
