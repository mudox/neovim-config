local opts = {
  task_list = {
    bindings = {
      ["+"] = "IncreaseDetail",
      ["-"] = "DecreaseDetail",
      ["g+"] = "IncreaseAllDetail",
      ["g-"] = "DecreaseAllDetail",

      [">"] = "DecreaseWidth",
      ["<"] = "IncreaseWidth",

      ["K"] = "PrevTask",
      ["J"] = "NextTask",
    },
  },

  task_editor = {
    bindings = {
      i = {
        ["<M-]>"] = "Next",
        ["<M-[>"] = "Prev",
      },
      n = {
        ["<M-]>"] = "Next",
        ["<M-[>"] = "Prev",
      },
    },
  },

  form = {
    border = "none",
    win_opts = {
      winblend = 0,
    },
  },

  task_win = {
    border = "none",
    win_opts = {
      winblend = 0,
    },
  },
}

require("overseer").setup(opts)
