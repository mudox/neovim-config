local keys = {
  { "<leader>x<Space>", "<Cmd>TroubleToggle<Cr>", desc = "Toggle Previous Trouble Window" },

  { "<leader>xx", "<Cmd>TroubleToggle document_diagnostics<Cr>", desc = "Document Diagnostics (Trouble)" },
  { "<leader>xX", "<Cmd>TroubleToggle workspace_diagnostics<Cr>", desc = "Workspace Diagnostics (Trouble)" },

  { "<leader>xl", "<cmd>troubletoggle loclist<cr>", desc = "Location List (Trouble)" },
  { "<leader>xq", "<cmd>troubletoggle quickfix<cr>", desc = "Quickfix List (Trouble)" },

  { "<leader>xr", "<Cmd>TroubleToggle lsp_references<Cr>", desc = "References List (Trouble)" },
}

return {
  "folke/trouble.nvim",
  cmd = { "TroubleToggle", "Trouble" },
  opts = { use_diagnostic_signs = true },
  keys = keys,
}
