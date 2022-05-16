local opts = {
  enable_persistent_history = true,
  continuous_sync = true,

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
