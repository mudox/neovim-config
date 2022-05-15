local opts = {
  keys = {
    telescope = {
      i = {
        select = "<Cr>",
        paste = "<C-l>",
        paste_behind = "<C-h>",
        replay = "<C-r>",
        delete = "<C-x>",
        custom = {},
      },
    },
  },
}

require("neoclip").setup(opts)
