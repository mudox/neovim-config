return {
  "simonmclean/triptych.nvim",
  dependencies = {
    "plenary.nvim",
    "nvim-web-devicons",

    "antosha417/nvim-lsp-file-operations", -- optional LSP integration
  },

  keys = {
    { "<leader>ft", "<Cmd>Triptych<Cr>", desc = "[Triptych] Toggle" },
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
