return {
  "stevearc/oil.nvim",
  -- stylua: ignore
  keys = {
    { "<leader>fo", function() require("oil").open() end, desc = "[Oil] Open", },
  },
  cmd = "Oil",
  opts = {
    keymaps = {
      ["<C-s>"] = "actions.select_split",

      ["<C-v>"] = "actions.select_vsplit",
      ["<C-h>"] = false,

      ["<C-c>"] = false,
      ["q"] = "actions.close",
    },
    keymaps_help = {
      border = "none",
    },
    float = {
      border = "none",
    },
    preview = {
      border = "none",
    },
    progress = {
      border = "none",
    },
    ssh = {
      border = "none",
    },
  },
}
