local keys = {
  { "<leader>xx", "<Cmd>TroubleToggle document_diagnostics<Cr>", desc = "Document Diagnostics (Trouble)" },
  { "<leader>xX", "<Cmd>TroubleToggle workspace_diagnostics<Cr>", desc = "Workspace Diagnostics (Trouble)" },
  { "<leader>xL", "<Cmd>TroubleToggle loclist<Cr>", desc = "Location List (Trouble)" },
  { "<leader>xQ", "<Cmd>TroubleToggle quickfix<Cr>", desc = "Quickfix List (Trouble)" },
}

return {
  "folke/trouble.nvim",
  cmd = { "TroubleToggle", "Trouble" },
  opts = { use_diagnostic_signs = true },
  keys = keys,
}
