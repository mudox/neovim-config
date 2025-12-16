local opts = {
  debug = {
    enabled = false,
    show_scores = false,
  },
  logging = {
    enabled = false,
  },

  title = "FFF",
  prompt = " 󰉁 ",
  hl = {
    normal = "mdx_frame_float",
    border = "mdx_frame_float_border",
  },
}

-- stylua: ignore
return {
  "dmtrKovalenko/fff.nvim",
  build = function() require("fff.download").download_or_build_binary() end,
  keys = {
    { K.p("f<Space>"), function() require("fff").find_files() end, desc = "[fff] open" },
    { K.sc("<Space>"), function() require("fff").find_files() end, desc = "[fff] open" },
  },
  opts = opts,
}
