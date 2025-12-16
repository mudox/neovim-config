return {
  "simonmclean/triptych.nvim",
  dependencies = {
    "plenary.nvim",
    "mini.nvim",

    "antosha417/nvim-lsp-file-operations", -- optional LSP integration
  },

  keys = {
    { K.p("ot"), "<Cmd>Triptych<Cr>", desc = "[triptych] toggle" },
  },

  opts = {
    options = {
      file_icons = {
        enabled = true,
      },

      line_numbers = {
        enabled = false,
      },

      backdrop = 100,
      transparency = 0,
    },

    git_signs = {
      enabled = false,
    },

    diagnostic_signs = {
      enabled = false,
    },
  },
}
