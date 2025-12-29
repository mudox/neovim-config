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
    normal = "mdx_f",
    border = "mdx_fb",
  },
}

-- stylua: ignore
return {
  "dmtrKovalenko/fff.nvim",
  build = function() require("fff.download").download_or_build_binary() end,
  keys = {
    { K.sc("<Space>"), function() require("fff").find_files() end, desc = "[fff] open" },
    { K.p("<Space>"),  function() require("fff").find_files() end, desc = "[fff] open" },
    { K.p("o<Space>"), function() require("fff").find_files() end, desc = "[fff] open" },
  },
  opts = opts,
}
