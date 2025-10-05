return {
  "A7Lavinraj/fyler.nvim",
  cmd = "Fyler",
  -- stylua: ignore
  keys = {
    { "<leader>ff", K.c"Fyler", desc = "[Fyler] Open" },
    { "<leader>fF", K.c"Fyler kind=float", desc = "[Fyler] Open float" },
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
